#!/usr/bin/env bash

install_brew_tools() {
	brew install z
	brew install ncdu
	# xml formatter
	brew install tidy-html5
}

install_exec() {
	echo -e "\nStart install home brew tools"
	install_brew_tools
}

install_exec
