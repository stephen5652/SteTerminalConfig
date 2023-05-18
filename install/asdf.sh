#!/usr/bin/env bash
#

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source ${CURRENT_DIR}/para.sh

asdf_install() {
	brew install asdf --verbose

	source ~/.bash_profile

	asdf install
	#	echo -e "\n. \"$(brew --prefix asdf)/libexec/asdf.sh\"" >>~/.bash_profile # has default writed to bash_profile
}

asdf_ruby() {
	asdf plugin add ruby
	asdf install ruby 2.7.5

	asdf global ruby 2.7.5
}

main_asdf() {
	asdf_install

	asdf_ruby
}

main_asdf
