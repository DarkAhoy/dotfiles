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
   echo "directory now is $(pwd)!"
   git clone $2
   echo "directory now is $(pwd)!"
   pushd $3
   make -j 8
   make install
   popd
   popd
}

add_key() {
   curl $1 | apt-key add -
}

add_repo_ugly() {
   echo $1 >> /etc/apt/sources.list
   apt update
}

install_all_deps() {
   
   cat apt-packages | grep -v "^#.*" | while read package
   do
	    if [[ $package == *"|"* ]]; then
         if [[ $(echo $package | tr -cd "|" | wc -c) == "1" ]]; then
            echo -e "{RED}ppa_repo is: $ppa_repo package is: $package{NC}" 
      		  IFS='|' read -r ppa_repo package<<<$(echo $package);
		        add_repo $ppa_repo
     		  apt_install $package
         else
            IFS='|' read -r ppa_repo key package<<<$(echo $package)
            echo -e "{RED} new! ppa_repo is: $ppa_repo key is: $key package is: $package {NC}" 
		        add_key $key
            add_repo_ugly "$ppa_repo"
		        apt_install $package
        fi 
	    else		  
		     apt_install $package
     	fi
   done

   for git_line in $(cat git-make-install | grep -v "#.*")
   do
	    IFS='|' read -r destination repo_path dir_name <<<$(echo $git_line);
	    git_make_install $destination $repo_path $dir_name 
   done  
}

install_kitty() {
   curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
   ln -sf $HOME/.local/kitty.app/bin/kitty /usr/local/bin/kitty   
   chown -R $SUDO_USER:$SUDO_USER $HOME/.config/kitty
}

install_polybar() {
   ./polybar_install.sh
}

configure_shell() {
   chsh -s $(which zsh) $SUDO_USER
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
   if [[ -f $HOME/.zshrc ]]; then 
      rm $HOME/.zshrc
   fi
}

main() {
	install_all_deps
	configure_shell 
	install_kitty
	install_polybar
  stow_all
	install_nvim_deps
}


install_nvim_deps() {
  curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  sudo chown -R $SUDO_USER:$SUDO_USER $HOME/.local/share/nvim
}


stow_all() {
   for d in $(cat stow-dirs | grep -v "^#.*")
   do 
      pushd ../
      stow $d
      popd
   done
}

edit_sudoers() {
	if grep -q "env_keep\=.*HOME.*"  /etc/sudoers ; then
		echo "HOME in keep_env"
	else
		echo "Defaults:$SUDO_USER env_keep=HOME" >> /etc/sudoers
    echo "Added keeping home in sudoers file, please run script again"
    exit 0
	fi
}

command=""
while getopts "ia" flag
do
 case "${flag}" in
  i) command="install";;
  a) command="all";;
 esac
done

edit_sudoers
pushd ~/dotfiles/ubuntu
if [[ "$command" == "install" ]]; then
 install_all_deps
else [[ "$command" == "all"  ||  -z $command ]]; 
 main
fi
popd
