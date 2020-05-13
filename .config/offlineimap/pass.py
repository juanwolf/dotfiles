#! /usr/bin/env python3
from subprocess import check_output


CLI="lpass"
EMAIL_PASS_ROOT="Email/"
LOGIN_ARG="--username"
PASS_ARG="--password"


def get_password(account):
    return check_output("lpass show " + EMAIL_PASS_ROOT + account + " " + PASS_ARG, shell=True).splitlines()[0].decode("utf-8")

def get_username(account):
    return check_output("lpass show " + EMAIL_PASS_ROOT + account + " " + LOGIN_ARG, shell=True).splitlines()[0].decode("utf-8")


if __name__ == "__main__":
    print(get_password("orange.fr"))
    print(get_username("orange.fr"))
