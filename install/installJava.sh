#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source ${CURRENT_DIR}/../para.sh

dest=$home_dir/jdk_20

install_java() {
	echo -e "\nStart install java"

	file_local=${home_dir}/Downloads/jdk_20.tar.gz
	if [[ ! -f $file_local ]]; then
	echo -e "\nStart loading jdk_20"
	wget https://download.oracle.com/java/20/latest/jdk-20_macos-aarch64_bin.tar.gz -O $file_local
	fi

	tmp=${home_dir}/DownLoads/jdk_20_tmp/
	if [[ -d $tmp ]]; then
		rm -rf $tmp
	fi

	mkdir -p $tmp

	tar -zxf $file_local -C $tmp
  echo -e "\ncmd: find $tmp -maxdepth 1 -name \"jdk*\" -print | head -n 1"

	jdk_dir=$(
  find $tmp/* -maxdepth 1 -name "jdk*" -print | head -n 1
)

echo -e "\nJdk dir:$jdk_dir"
if [[ -d $jdk_dir ]]; then

	if [[ -d $dest ]]; then
		rm -rf $dest
	fi

	cp -r $jdk_dir $dest


  java_env="
  \\n
JAVA_HOME=$dest/Contents/Home
\\n
CLASSPAHT=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
\\n
export PATH=\$JAVA_HOME/bin:\$PATH:
  "
  echo -e $java_env >> $home_dir/.bash_profile
   
	source ${home_dir}/.zshrc
  else
    echo -e "\nFailed, since Jdk dir not found:$jdk_dir"
fi
}

main_java() {
	echo -e "home:${home_dir}"
	install_java
}

main_java
