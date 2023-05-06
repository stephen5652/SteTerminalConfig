#!/bin/bash
#
install_tool() {
	echo -e "homebrew install tools\n"

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

	echo -e "\nbeging cp tmux config"
	cp -f ~/.config/nvim/.tmux.conf ~/.tmux.conf
}

main() {
	install_tool
	install_plugin_implementations
	install_dap_debug
	install_tmux
}

main
