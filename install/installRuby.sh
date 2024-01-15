#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source ${CURRENT_DIR}/para.sh

installRuby() {
	echo -e "\nStart install ruby lsp"

	gem install solargraph
}

main() {
	installRuby
}

main
