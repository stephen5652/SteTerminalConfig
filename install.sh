#!/bin/bash
#
install_tool() {
	echo -e "homebrew install tools\n"

	brew install wget nodejs yarn
	npm config set registry http://registry.npmmirror.com
	yarn config set registry http://registry.npmmirror.com

	echo -e "\nhomebrew install tools finish"
}

install_dap_debug() {
	echo -e "\nbeging install dap debug\n"

	# codelldb
	echo "install codelldb"
	rm -rf ~/.local/share/nvim/data/debug/tools
	mkdir -pv ~/.local/share/nvim/data/debug/tools
	wget https://github.com/vadimcn/codelldb/releases/download/v1.9.0/codelldb-x86_64-darwin.vsix -P ~/Downloads
	unzip -d ~/.local/share/nvim/data/debug/tools/ ~/Downloads/codelldb-x86_64-darwin.vsix

	# java
	echo "install jdtls"
	wget https://download.eclipse.org/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz -P ~/Downloads
	rm -rf ~/.local/share/nvim/lsp/jdt-language-server/workspace/folder
	mkdir -pv ~/.local/share/nvim/lsp/jdt-language-server/workspace/folder
	tar -zxvf ~/Downloads/jdt-language-server-1.9.0-202203031534.tar.gz -C ~/.local/share/nvim/lsp/jdt-language-server

	# add env
	echo '### neovim install created PATH, you should delete the duplicate ones manually'
	echo 'export JDTLS_HOME=$HOME/.local/share/nvim/lsp/jdt-language-server/  # 包含 plugin 和 configs 的目录，由jdt-language-server-xxx.tar.gz解压出的' >>~/.bash_profile
	echo 'export WORKSPACE=$HOME/.local/share/nvim/lsp/jdt-language-server/workspace/ # 不设置则默认是$HOME/workspace' >>~/.bash_profile

	echo "install java17"
	wget https://download.oracle.com/java/17/latest/jdk-17_macos-aarch64_bin.tar.gz -P ~/Downloads
	rm -rf ~/Java
	mkdir -pv ~/Java
	tar -zxvf ~/Downloads/jdk-17_macos-aarch64_bin.tar.gz -C ~/Java/

	echo -e "\nhomebrew install dap debug finish\n"
}

main() {
	install_tool
	install_dap_debug
}

main
