import importlib.util
import pathlib
import unittest


SCRIPT_PATH = pathlib.Path(__file__).resolve().parents[1] / "scripts" / "jump.py"


def load_jump_module():
    spec = importlib.util.spec_from_file_location("jump", SCRIPT_PATH)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class JumpScriptTest(unittest.TestCase):
    def setUp(self):
        self.jump = load_jump_module()

    def test_aws_describe_command_filters_running_instances_by_name_prefix(self):
        cmd = self.jump.build_aws_describe_command(
            "api",
            profile="dev",
            region="eu-west-1",
        )

        self.assertEqual(
            cmd,
            [
                "aws",
                "ec2",
                "describe-instances",
                "--filters",
                "Name=tag:Name,Values=api*",
                "Name=instance-state-name,Values=running",
                "--output",
                "json",
                "--profile",
                "dev",
                "--region",
                "eu-west-1",
            ],
        )

    def test_parse_hosts_returns_sorted_named_private_ips(self):
        payload = {
            "Reservations": [
                {
                    "Instances": [
                        {
                            "InstanceId": "i-002",
                            "Tags": [{"Key": "Name", "Value": "api-b"}],
                            "NetworkInterfaces": [
                                {"PrivateIpAddress": "10.0.2.25"}
                            ],
                        }
                    ]
                },
                {
                    "Instances": [
                        {
                            "InstanceId": "i-001",
                            "Tags": [{"Key": "Name", "Value": "api-a"}],
                            "PrivateIpAddress": "10.0.1.15",
                        },
                        {
                            "InstanceId": "i-003",
                            "Tags": [{"Key": "Name", "Value": "api-c"}],
                            "NetworkInterfaces": [],
                        },
                    ]
                },
            ]
        }

        hosts = self.jump.parse_hosts(payload)

        self.assertEqual(
            [(host.name, host.instance_id, host.private_ip) for host in hosts],
            [
                ("api-a", "i-001", "10.0.1.15"),
                ("api-b", "i-002", "10.0.2.25"),
            ],
        )

    def test_ssh_command_uses_private_ip_with_optional_user_and_identity_file(self):
        host = self.jump.EC2Host("api-a", "i-001", "10.0.1.15")

        cmd = self.jump.build_ssh_command(
            host,
            user="ec2-user",
            identity_file="/tmp/key.pem",
            strict_host_key_checking=False,
        )

        self.assertEqual(
            cmd,
            [
                "ssh",
                "-o",
                "StrictHostKeyChecking=no",
                "-i",
                "/tmp/key.pem",
                "ec2-user@10.0.1.15",
            ],
        )

    def test_tmux_commands_create_one_host_pane_per_match(self):
        hosts = [
            self.jump.EC2Host("api-a", "i-001", "10.0.1.15"),
            self.jump.EC2Host("api-b", "i-002", "10.0.2.25"),
            self.jump.EC2Host("api-c", "i-003", "10.0.3.35"),
        ]

        plan = self.jump.build_tmux_plan(
            hosts,
            prefix="api",
            user="ubuntu",
            identity_file=None,
            strict_host_key_checking=False,
        )

        self.assertEqual(
            plan.start_command,
            [
                "tmux",
                "new-window",
                "-d",
                "-P",
                "-F",
                "#{window_id}",
                "-n",
                "jump-api",
                "ssh -o StrictHostKeyChecking=no ubuntu@10.0.1.15",
            ],
        )
        self.assertEqual(
            plan.split_commands("window-1"),
            [
                [
                    "tmux",
                    "split-window",
                    "-d",
                    "-t",
                    "window-1",
                    "ssh -o StrictHostKeyChecking=no ubuntu@10.0.2.25",
                ],
                [
                    "tmux",
                    "split-window",
                    "-d",
                    "-t",
                    "window-1",
                    "ssh -o StrictHostKeyChecking=no ubuntu@10.0.3.35",
                ],
            ],
        )
        self.assertEqual(
            plan.finalize_commands("window-1"),
            [
                ["tmux", "select-layout", "-t", "window-1", "tiled"],
                ["tmux", "select-window", "-t", "window-1"],
            ],
        )


if __name__ == "__main__":
    unittest.main()
