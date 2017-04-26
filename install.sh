#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

rsync --exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude "install.sh" \
	--exclude "README.md" \
	-avh --no-perms . ~;

