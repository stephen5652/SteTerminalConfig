#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source ${CURRENT_DIR}/para.sh

install_vue() {
	echo -e "\nStart install vue for neovim"
	npm install -g @volar/vue-language-server
}

main_vue() {
	echo -e "home:${home_dir}"
	install_vue
}

main_vue
