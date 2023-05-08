#!/bin/bash
#

safe_link() {
	source=$1
	des=$2

	des_dir=${des%/*}
	if [[ ! -d ${des_dir} ]]; then
		echo -e "should make path:${des_dir}"
		mkdir -p ${des_dir}
	fi

	if [[ -d ${des} || -f ${des} ]]; then
		if [[ -L ${des} ]]; then # is link
			echo -e "Warning: link is existed, we remove it:${des}"
			rm ${des}
		else

			time=$(date "+%Y%m%d-%H%M%S")
			echo -e "Warning: file existed ${des} , rename it to ${des}_bak_${time}"
			mv ${des} ${des}_${time}
		fi
	fi

	echo -e "ln -s ${source} ${des}"
	ln -s ${source} ${des}
}

link_nvim_config() {
	echo -e "\nStart link nvim config"
	nvim_name=~/.config/nvim
	real_nvim_config=$(pwd)/nvim
	safe_link ${real_nvim_config} ${nvim_name}
}

install_tool() {
	echo -e "\nstarging homebrew install tools\n"

	brew install wget nodejs yarn
	npm config set registry http://registry.npmmirror.com
	yarn config set registry http://registry.npmmirror.com

	echo -e "\nhomebrew install tools finish"
}

install_plugin_implementations() {
	echo -e "Start install nvim plugin implentations\n"
	brew install lazygit

	brew install ripgrep # plugins for telescope, nvim command: checkhealth telescope
	brew install fd      # plugins for telescope, nvim command: checkhealth telescope

	brew install swiftlint        # enable  null-ls swiftlint
	brew install astyle --verbose # enable null-ls astyle

	gem install neovim # enable ruby language

	npm install -g vls # enable vue language
	echo -e "Finish install nvim plugins implementations\n"
}

install_dap_debug() {
	echo -e "\nbeging install dap debug\n"

	# codelldb
	echo "install codelldb"
	rm -rf ~/.local/share/nvim/data/debug/tools
	mkdir -pv ~/.local/share/nvim/data/debug/tools
	wget https://github.com/vadimcn/codelldb/releases/download/v1.9.0/codelldb-x86_64-darwin.vsix -P ~/Downloads
	unzip -d ~/.local/share/nvim/data/debug/tools/ ~/Downloads/codelldb-x86_64-darwin.vsix

	echo -e "\ninstall codelldb finish\n"
}

install_tmux() {
	echo -e "\nbeging install tmux"

	brew install tmux

	echo -e "\nbeging link tmux config"
	source=$(pwd)/tmux/tmux.conf
	des=~/.tmux.conf
	safe_link ${source} ${des}
}

install_yabai() {
	echo -e "\nBeging install yabai"

	source=$(pwd)/yabai/yabairc
	dest=~/.config/yabai/yabairc
	safe_link ${source} ${dest}

	brew install koekeishiya/formulae/yabai --HEAD
	codesign -fs 'yabai-cert' $(which yabai)
	yabai --start-service

}

install_skhd() {
	echo -e "\nStart install shkd"

	source=$(pwd)/skhd/skhdrc
	dest=~/.config/skhd/skhdrc
	safe_link ${source} ${dest}

	brew install koekeishiya/formulae/skhd
	skhd --stop-service
	skhd --start-service
}

install_lazygit() {
	echo -e "\nStart install lazygit"
	brew install lazygit
}

main() {
	install_tmux

	install_yabai

	install_skhd

	install_lazygit

	link_nvim_config
	install_tool
	install_plugin_implementations
	install_dap_debug
}

main
