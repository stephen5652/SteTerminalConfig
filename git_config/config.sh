
#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

home_dir=$HOME

DEST_LN="${home_dir}/.git_commit_template"


config_git_template() {
	echo -e "\nconfig git_commit_template"

	if [[ -d "${DEST_LN}" ]]; then
			time=$(date "+%Y%m%d-%H%M%S")
			echo -e "Warning: file existed \"${des}\" , rename it to \"${des}_bak_${time}\""
			mv "${des}" "${des}_${time}"
	fi

  echo "cmd: ln -s \"${CURRENT_DIR}/commit_template\" \"${DEST_LN}\""

	ln -s "${CURRENT_DIR}/commit_template" "${DEST_LN}" 
  git config --global commit.template "${DEST_LN}" 
}

main() {
	config_git_template
}

main
