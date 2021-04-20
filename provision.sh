#!/bin/sh
# Filename: provision.sh
# Author: John Cunniff
# Date: 2021-04-20


# Please Note:
#   Running your own VM is OPTIONAL! We recommend you just use the
#   class cloud VM on vital that has all this set up already. Use
#   your own VM and this script at your own peril.

# Description:
#   Use this script to provision an ubuntu 20.04 or 18.04 VM for
#   Intro to Operating Systems CS-UY 3224. This will install
#   and configure everything you will need for the class.
#   If you are already daily driving linux, then you can
#   pick and choose which stuff to install from this script.


set -ex # Exit if a command fails, and print commands as we go
cd ~

# Install the basics
export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt upgrade -y
sudo apt install -y \
     git \
     zsh \
     gdb \
     lldb \
     curl \
     cargo \
     qemu-system-x86 \
     build-essential \
     gcc-multilib \
     libc6-i386 \
     python3 \
     python3-pip

# Setup pwndbg and gdb
git clone https://github.com/pwndbg/pwndbg.git  # For pretty gdb
cd pwndbg
./setup.sh
echo >> /home/vagrant/.gdbinit
echo "set auto-load safe-path /" >> /home/vagrant/.gdbinit
cd ..

# ZSH (make that shell pretty)
cd /home/vagrant
git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh  # ZSH library with plugins for making things better
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    .oh-my-zsh/custom/plugins/zsh-syntax-highlighting  # Command line syntax highlighting (welcome to the 21st century)
cp .oh-my-zsh/templates/zshrc.zsh-template .zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gnzh"/' .zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting)/' .zshrc
sudo chsh -s $(which zsh) vagrant # Change shell to zsh for the current user
su vagrant -c "cargo install exa" # Pretty ls https://github.com/ogham/exa
>> .zshrc cat<<EOF
export PATH="/home/vagrant/.cargo/bin:$PATH"
export TERM=xterm-256color
if which exa &> /dev/null; then
    alias la='exa -abghlT --ignore-glob=".bzr|CVS|.git|.hg|.svn|node_modules|__pycache__" --git'
    alias l='exa -abghl --git'
else
    alias la='ls --color=auto -a'
    alias l='ls --color=auto -aCFlh'
fi
EOF

chown -R vagrant:vagrant /home/vagrant
