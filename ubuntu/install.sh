#!/bin/bash

set -e

apt_install () {
   apt install -y $1
}

add_repo () {
   add-apt-repository -y $1
}

git_make_install() {
   pushd $1
   git clone $2
   cd $3
   make -j 8
   make install
   popd
}

install_all_deps() {
   for package in $(cat apt-packages | grep -v "^#.*") 
   do	
	if [[ $package == *"|"* ]]; then
		read -r ppa_repo package <<<$(echo $package | awk -F '|' '{print $1" "$2}');
		add_repo $ppa_repo
		apt_install $package
	else		  
		apt_install $package
	fi
   done

   for git_line in $(cat git-make-install | grep -v "#.*")
   do
	    read -r destination repo_path dir_name <<<$(echo $git_line | awk -F '|' '{print $1" "$2" "$3}');
	    git_make_install $destination $repo_path $dir_name 
   done  
}

install_kitty() {
   curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
   ln -sf ~/.local/kitty.app/bin/kitty /usr/local/bin/kitty    
}

install_polybar() {
   ./install_polybar.sh
}

configure_shell() {
   chsh -s $(which zsh)
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

main() {
	install_all_deps
	configure_shell 
	install_kitty
	install_polybar
}


command=""
while getopts "ia" flag
do
 case "${flag}" in
  i) command="install";;
  a) command="all";;
 esac
done

pushd ~/dotfiles/ubuntu
if [[ "$command" == "install" ]]; then
 install_all_deps
else [[ "$command" == "all"  ||  -z $command ]]; 
 main
fi
popd
