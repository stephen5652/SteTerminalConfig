#!/usr/bin/env bash
#
#

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source $CURRENT_DIR/para.sh
install_terminal_tools() {

	brew install thefuck --verbose

}

install_terminal_tools
