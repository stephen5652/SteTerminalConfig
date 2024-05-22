#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

home_dir=$HOME

DEST_LN="${home_dir}/Library/Application Support/Code/User/settings.json"


config_vs_code() {
	echo -e "\nconfig vs_code"

	if [[ -d "${DEST_LN}" ]]; then
		rm $DEST_LN
	fi

  echo "cmd: ln -s \"${CURRENT_DIR}/settings.json\" \"${DEST_LN}\""

	ln -s "${CURRENT_DIR}/settings.json" "${DEST_LN}" 
}

main() {
	config_vs_code
}

main
