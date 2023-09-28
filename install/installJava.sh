#!/usr/bin/env bash

CURRENT_DIR=$(
	cd $(dirname $0)
	pwd
)

source ${CURRENT_DIR}/para.sh

install_java() {
	echo -e "\nStart install java"
	asdf install java openjdk-17
	asdf global java openjdk-17
}

env_name=ste_java_env
source_java_env() {
	java_env_path=${CURRENT_DIR}/../java/java_env
	env_ln=${home_dir}/${env_name}
	safe_link ${java_env_path} ${env_ln}

	env_str="source \${HOME}/${env_name}"

	echo -e "\njava env str:${env_str}"
	echo -e "\nbash_path: ${bash_profile_path}"
	if [[ -z $(cat ${bash_profile_path} | grep "${env_str}") ]]; then
		echo -e "should add source str: ${env_str}"

		echo -e "\\n${env_str}" >>${bash_profile_path}
	else
		echo -e "\n had sourced java_env: ${env_str}"
	fi
}

# since java_debug only support jdk_17, so this shell only install jdk17
local_java_debug=$home_dir/.local/share/nvim/jdtls/java-debug_17
local_lombok=$home_dir/.local/share/nvim/jdtls/lombok.jar
install_java_debug() {
	echo -e "\n Start install jdtls"
	brew install jdtls

	echo -e "\n Start install lombok"
	if [[ -f ${local_lombok} ]]; then
		echo -e "\nFile existed, remove it first: ${local_lombok}"
		rm ${local_lombok}
	fi
	echo -e "Start load lombok"
	wget https://projectlombok.org/downloads/lombok.jar -O ${local_lombok}

	echo -e "\n Start install java-debug_17"
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
	install_java
	source_java_env

	source $home_dir/.bash_profile
	install_java_debug

	echo -e "\nWarning: since java-debug only support jdk17, this project has change your JAVA_HOME to jdk17, view your java_env file:\${HOME}/${env_name}"
}

main_java
