#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

home_dir=$HOME

DEST_LN="${home_dir}/.aerospace.toml"


config_vs_code() {
	echo -e "\nconfig aerospace"

	if [[ -d "${DEST_LN}" ]]; then
		rm $DEST_LN
	fi

  echo "cmd: ln -s \"${CURRENT_DIR}/aerospace.toml\" \"${DEST_LN}\""

	ln -s "${CURRENT_DIR}/settings.json" "${DEST_LN}" 
}

main() {
	config_vs_code
}

main
