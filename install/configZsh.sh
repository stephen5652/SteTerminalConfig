#!/usr/bin/env bash
#

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

ZSH_DIR=$(
	cd $CURRENT_DIR/../zsh
	pwd
)

source $CURRENT_DIR/para.sh

config_zsh() {
	echo -e "\nStart config zsh:${ZSH_DIR}"
	if [[ -d ${ZSH_CUSTOM:-${home_dir}/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
		echo -e "\nWarning: pk10 has installed, we remove it first"
		rm -rf -- ${ZSH_CUSTOM:-${home_dir}/.oh-my-zsh/custom}/themes/powerlevel10k
	fi
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-${home_dir}/.oh-my-zsh/custom}/themes/powerlevel10k

	if [[ -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
		echo -e "\nWarning: plugins existed, remove it first: ${ZSH_CUSTOM:-${home_dir}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
		rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions
	fi
	git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-${home_dir}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

	if [[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
		echo -e "\nWarning: plugins existed, remove it first: ${ZSH_CUSTOM:-${home_dir}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
		rm -rf $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	fi
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

	if [[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z ]]; then
		echo -e "\nWarning: plugins existed, remove it first: ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z"
		rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
	fi
	git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z

	source=$ZSH_DIR/zshrc
	echo -e "\nsource:${source}"
	dest=${home_dir}/.zshrc
	safe_link ${source} ${dest}
}

config_p10k() {
	echo -e "\nStart config p10k"
	source=$ZSH_DIR/p10k.zsh
	dest=${home_dir}/.p10k.zsh
	safe_link ${source} ${dest}
}

main_config() {
	config_zsh
	config_p10k

	zsh
	source ${home_dir}/.zshrc
}

main_config
