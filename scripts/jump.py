#!/usr/bin/env python3
import argparse
import json
import os
import re
import shlex
import subprocess
import sys
from dataclasses import dataclass
from typing import Any, Dict, Iterable, List, Optional, Tuple


class JumpError(Exception):
    pass


@dataclass(frozen=True)
class EC2Host:
    name: str
    instance_id: str
    private_ip: str


@dataclass(frozen=True)
class TmuxPlan:
    start_command: List[str]
    hosts: Tuple[EC2Host, ...]
    user: Optional[str]
    identity_file: Optional[str]
    strict_host_key_checking: bool

    def split_commands(self, window_id: str) -> List[List[str]]:
        return [
            [
                "tmux",
                "split-window",
                "-d",
                "-t",
                window_id,
                format_command(
                    build_ssh_command(
                        host,
                        user=self.user,
                        identity_file=self.identity_file,
                        strict_host_key_checking=self.strict_host_key_checking,
                    )
                ),
            ]
            for host in self.hosts[1:]
        ]

    def finalize_commands(self, window_id: str) -> List[List[str]]:
        return [
            ["tmux", "select-layout", "-t", window_id, "tiled"],
            ["tmux", "select-window", "-t", window_id],
        ]


def build_aws_describe_command(
    prefix: str,
    profile: Optional[str] = None,
    region: Optional[str] = None,
) -> List[str]:
    command = [
        "aws",
        "ec2",
        "describe-instances",
        "--filters",
        f"Name=tag:Name,Values={prefix}*",
        "Name=instance-state-name,Values=running",
        "--output",
        "json",
    ]
    if profile:
        command.extend(["--profile", profile])
    if region:
        command.extend(["--region", region])
    return command


def parse_hosts(payload: Dict[str, Any]) -> List[EC2Host]:
    hosts = []
    for reservation in payload.get("Reservations", []):
        for instance in reservation.get("Instances", []):
            private_ip = private_ip_for(instance)
            if not private_ip:
                continue

            instance_id = instance.get("InstanceId", "")
            hosts.append(
                EC2Host(
                    name=name_for(instance) or instance_id or private_ip,
                    instance_id=instance_id,
                    private_ip=private_ip,
                )
            )

    return sorted(hosts, key=lambda host: (host.name, host.instance_id, host.private_ip))


def private_ip_for(instance: Dict[str, Any]) -> Optional[str]:
    if instance.get("PrivateIpAddress"):
        return instance["PrivateIpAddress"]

    for interface in instance.get("NetworkInterfaces", []):
        if interface.get("PrivateIpAddress"):
            return interface["PrivateIpAddress"]
    return None


def name_for(instance: Dict[str, Any]) -> Optional[str]:
    for tag in instance.get("Tags", []):
        if tag.get("Key") == "Name":
            return tag.get("Value")
    return None


def build_ssh_command(
    host: EC2Host,
    user: Optional[str] = None,
    identity_file: Optional[str] = None,
    strict_host_key_checking: bool = False,
) -> List[str]:
    command = ["ssh"]
    if not strict_host_key_checking:
        command.extend(["-o", "StrictHostKeyChecking=no"])
    if identity_file:
        command.extend(["-i", identity_file])

    target = host.private_ip
    if user:
        target = f"{user}@{target}"
    command.append(target)
    return command


def build_tmux_plan(
    hosts: Iterable[EC2Host],
    prefix: str,
    user: Optional[str] = None,
    identity_file: Optional[str] = None,
    strict_host_key_checking: bool = False,
) -> TmuxPlan:
    host_tuple = tuple(hosts)
    if not host_tuple:
        raise JumpError("no hosts available for tmux")

    window_name = f"jump-{slugify(prefix)}"
    start_command = [
        "tmux",
        "new-window",
        "-d",
        "-P",
        "-F",
        "#{window_id}",
        "-n",
        window_name,
        format_command(
            build_ssh_command(
                host_tuple[0],
                user=user,
                identity_file=identity_file,
                strict_host_key_checking=strict_host_key_checking,
            )
        ),
    ]
    return TmuxPlan(
        start_command=start_command,
        hosts=host_tuple,
        user=user,
        identity_file=identity_file,
        strict_host_key_checking=strict_host_key_checking,
    )


def slugify(value: str) -> str:
    slug = re.sub(r"[^A-Za-z0-9_.-]+", "-", value).strip("-")
    return slug or "hosts"


def run_aws_describe(
    prefix: str,
    profile: Optional[str],
    region: Optional[str],
) -> Dict[str, Any]:
    command = build_aws_describe_command(prefix, profile=profile, region=region)
    completed = subprocess.run(command, capture_output=True, text=True)
    if completed.returncode != 0:
        detail = completed.stderr.strip() or completed.stdout.strip()
        raise JumpError(f"AWS describe-instances failed: {detail}")

    try:
        return json.loads(completed.stdout)
    except json.JSONDecodeError as exc:
        raise JumpError(f"AWS returned invalid JSON: {exc}") from exc


def connect_one(hosts: List[EC2Host], args: argparse.Namespace) -> int:
    host = hosts[0]
    if len(hosts) > 1:
        print(
            f"jump: found {len(hosts)} matches; connecting to "
            f"{host.name} ({host.private_ip}). Use -a/--all for tmux panes.",
            file=sys.stderr,
        )

    command = build_ssh_command(
        host,
        user=args.user,
        identity_file=args.identity_file,
        strict_host_key_checking=args.strict_host_key_checking,
    )
    if args.dry_run:
        print(format_command(command))
        return 0
    return subprocess.call(command)


def connect_all(hosts: List[EC2Host], args: argparse.Namespace) -> int:
    if not args.dry_run and not os.environ.get("TMUX"):
        raise JumpError("-a/--all must be run from inside an active tmux session")

    plan = build_tmux_plan(
        hosts,
        prefix=args.prefix,
        user=args.user,
        identity_file=args.identity_file,
        strict_host_key_checking=args.strict_host_key_checking,
    )

    if args.dry_run:
        print(format_command(plan.start_command))
        for command in plan.split_commands("<window_id>"):
            print(format_command(command))
        for command in plan.finalize_commands("<window_id>"):
            print(format_command(command))
        return 0

    window_id = subprocess.check_output(plan.start_command, text=True).strip()
    if not window_id:
        raise JumpError("tmux did not return a window id")

    for command in plan.split_commands(window_id):
        subprocess.check_call(command)
    for command in plan.finalize_commands(window_id):
        subprocess.check_call(command)
    return 0


def format_command(command: List[str]) -> str:
    return shlex.join(command)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="SSH to running EC2 instances whose Name tag starts with a prefix.",
    )
    parser.add_argument("prefix", help="EC2 Name tag prefix to search for")
    parser.add_argument(
        "-a",
        "--all",
        action="store_true",
        help="open all matching hosts as tmux panes",
    )
    parser.add_argument("-u", "--user", help="SSH username")
    parser.add_argument("-i", "--identity-file", help="SSH identity file")
    parser.add_argument("--profile", help="AWS CLI profile")
    parser.add_argument("--region", help="AWS region")
    parser.add_argument(
        "--strict-host-key-checking",
        action="store_true",
        help="leave SSH host key checking enabled",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="print the SSH/tmux commands instead of running them",
    )
    return parser


def main(argv: Optional[List[str]] = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    try:
        hosts = parse_hosts(run_aws_describe(args.prefix, args.profile, args.region))
        if not hosts:
            raise JumpError(f"no running EC2 instances found for prefix '{args.prefix}'")

        if args.all:
            return connect_all(hosts, args)
        return connect_one(hosts, args)
    except JumpError as exc:
        print(f"jump: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
