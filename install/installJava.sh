#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source ${CURRENT_DIR}/para.sh

url_20=https://download.oracle.com/java/20/latest/jdk-20_macos-aarch64_bin.tar.gz
dest_20=$home_dir/jdk_20
file_local_20=${home_dir}/Downloads/jdk_20.tar.gz

url_17=https://download.oracle.com/java/17/latest/jdk-17_macos-aarch64_bin.tar.gz
dest_17=$home_dir/jdk_17
file_local_17=${home_dir}/Downloads/jdk_17.tar.gz

install_java() {
	echo -e "\nStart install java"

	# file_local=${home_dir}/Downloads/jdk_20.tar.gz
	file_local=$1
	dest=$2
	url_jdk=$3

	echo -e "local:$file_local"
	echo -e "dest:$dest"
	echo -e "url:$url_jdk"

	if [[ ! -f $file_local ]]; then
		echo -e "\nStart loading jdk:"
		wget $url_jdk -O $file_local
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
		echo -e $java_env >>$home_dir/.bash_profile

		source ${home_dir}/.bash_profile
	else
		echo -e "\nFailed, since Jdk dir not found:$jdk_dir"
	fi
}

# since java_debug only support jdk_17, so this shell only install jdk17
local_java_debug=$home_dir/.local/share/nvim/jdtls/java-debug_17
install_java_debug() {
	brew install jdtls
	if [[ -d $local_java_debug ]]; then
		echo -e "\nJava debug has loaded, remove it firstly:$local_java_debug"
		rm -rf $local_java_debug
	fi

	git clone https://github.com/microsoft/java-debug.git $local_java_debug

	cd $local_java_debug
	./mvnw clean install
}

main_java() {
	echo -e "home:${home_dir}"
	install_java $file_local_17 $dest_17 $url_17

	source $home_dir/.bash_profile
	install_java_debug

	echo -e "\nWarning: since java-debug only support jdk17, this project has change your JAVA_HOME to jdk17, view your bash profile:$home_dir/.bash_profile"
}

main_java
