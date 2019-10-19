#! /usr/bin/env python3
from subprocess import check_output


EMAIL_PASS_ROOT="Email/"
LOGIN_PREFIX="login: "


def get_password(account):
    return check_output("pass " + EMAIL_PASS_ROOT + account, shell=True).splitlines()[0].decode("utf-8")


def get_username(account):
    for line in  check_output("pass " + EMAIL_PASS_ROOT + account, shell=True).splitlines():
        line = line.decode("utf-8")
        if line.startswith(LOGIN_PREFIX):
            login = line[len(LOGIN_PREFIX):len(line)]
            return login
    return ""


if __name__ == "__main__":
    print(get_password("orange.fr"))
    print(get_username("orange.fr"))
