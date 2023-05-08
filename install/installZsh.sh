#!/bin/bash
#
home_dir=${HOME}

install_zsh() {
	echo -e "\nStart install zsh"

	echo -e "\nAfter install finish, you should run config.sh"

	#install pk10

	brew install zsh

	if [[ -d ${home_dir}/.oh-my-zsh ]]; then
		rm -rf ${home_dir}/.oh-my-zsh
	fi
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

main() {
	install_zsh
}

main
