#!/bin/python3

from optparse import OptionParser

import os

EXCLUDES = [
    ".gitignore",
    ".gitmodules",
    "Dockerfile",
    "LICENSE.txt",
    "README.md",
    "install.py",
    "install.sh",
]


def install():
    """ install will push the FILES to the HOME directory"""
    home_dir = os.GetEnv("HOME")


def uninstall():
    """ Removes all the dotfiles from this project in your home directory"""
    pass


if __name__ == "main":

    force_mode = False
    parser = OptionParser()
    parser.add_option(
        "-f",
        "--force",
        action="store_true",
        help="Uninstall dotfiles before installing them! WARNING: It will delete exis",
        destination=force_mode,
    )
    parser.parse_args()

    if FORCE_MODE:
        uninstall()

    install()
