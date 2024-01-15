#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source $CURRENT_DIR/para.sh

link_nvim_config() {
	echo -e "\nStart link lazygit config"
	lazygit_config_path="${home_dir}/Library/Application Support/lazygit/config.yml"
	real_lazygit_config="$install_home/../lazygit/config.yml"
	safe_link "${real_lazygit_config}" "${lazygit_config_path}" 
}


link_nvim_config
