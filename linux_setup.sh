#!/usr/bin/env sh

EX_OK=0
EX_ERR=1
EX_USAGE=64

ROOT_HOME="/root"

usage()
{
    # Print usage message
    cat << EOF
Usage $0 [options]

Setup a Linux system.

OPTIONS:
    -h Show this message
    -c Clone configuration files
    -C Install Google Chrome
    -z Install and setup ZSH shell
    -t Install and setup tmux
    -v Install and setup vim editor
    -g Setup git version control
    -3 Setup i3 config
    -r Apply some of this config to root
    -f Install packages for Fedora
    -h Remove the default dirs in ~ that I find useless
EOF
}

clone_dotfiles()
{
    # Grab repo of Linux configuration files
    if ! command -v git &> /dev/null; then
        sudo dnf install -y git
    fi
    if [ ! -d $HOME/.dotfiles ]
    then
        git clone https://bitbucket.org/jellybean7555/dotfiles.git $HOME/.dotfiles
    fi
}

install_zsh()
{
    # Install and configure ZSH. Can be used stand-alone.
    # Usecase: dev boxes that you want mostly fresh, but need zsh
    if ! command -v zsh &> /dev/null; then
        sudo dnf install -y zsh
    fi

    # Symlink my ZSH config to proper path
    clone_dotfiles
    ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc

    # Grab general ZSH config via oh-my-zsh project
    # See https://github.com/robbyrussell/oh-my-zsh
    git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh 
    git clone https://github.com/bhilburn/powerlevel9k.git \
      ~/.oh-my-zsh/custom/themes/powerlevel9k
    # Set ZSH as my default shell
    chsh -s `command -v zsh`
}

install_tmux()
{
    # Stand-alone function for installing/setting up only tmux
    # Usecase: dev boxes that you want mostly fresh, but need tmux
    if ! command -v tmux &> /dev/null; then
        sudo dnf install -y tmux
    fi
    clone_dotfiles
    # Symlink tmux config to proper path
    ln -s $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
}

install_vim()
{
    # Stand-alone function for installing/setting up only vim
    # Usecase: dev boxes that you want mostly fresh, but need vim
    if ! command -v vim &> /dev/null; then
        sudo dnf update -y vim-minimal
        sudo dnf install -y vim-X11 vim
    fi
    clone_dotfiles
    # Symlink vim config to proper path
    ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc
}

install_git()
{
    # Symlink git config to proper path
    # The clone_dotfiles installs git if it isn't installed already
    clone_dotfiles
    ln -s $HOME/.dotfiles/gitconfig $HOME/.gitconfig
}

install_i3()
{
    # Install i3 WM if it isn't already installed
    if ! command -v i3 &> /dev/null; then
        sudo dnf install -y i3
    fi
    # Install i3status, used by i3 WM, if it isn't already installed
    if ! command -v i3status &> /dev/null; then
        sudo dnf install -y i3status
    fi

    # Clone configs, including i3 and i3status configurations 
    clone_dotfiles

    # Create required dir for i3 config, if it doesn't exist    
    if [ ! -d $HOME/.i3 ]
    then
        mkdir $HOME/.i3
    fi

    # Symlink i3 WM config to proper path
    ln -s $HOME/.dotfiles/i3_config $HOME/.i3/config

    # Symlink i3status config to proper path
    ln -s $HOME/.dotfiles/i3status.conf $HOME/.i3status.conf
}

setup_root()
{
    # Apply ZSH, vim, git and tmux config to root
    # TODO: Give root a different ZSH prompt
    clone_dotfiles
    sudo ln -s $HOME/.dotfiles/zshrc $ROOT_HOME/.zshrc
    sudo ln -s $HOME/.oh-my-zsh $ROOT_HOME/.oh-my-zsh
    sudo chsh -s `command -v zsh`

    # Create additional symlinks to give root similar config
    sudo ln -s $HOME/.dotfiles/vimrc $ROOT_HOME/.vimrc
    sudo ln -s $HOME/.dotfiles/gitconfig $ROOT_HOME/.gitconfig
    sudo ln -s $HOME/.dotfiles/tmux.conf $ROOT_HOME/.tmux.conf
}

install_chrome()
{
    # Add Google Chrome repo to yum's sources
    sudo bash -c "cat >/etc/yum.repos.d/google-chrome.repo <<EOL
[google-chrome]
name=google-chrome - 64-bit
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOL"
    sudo dnf install -y google-chrome-stable
}

fedora_packages()
{
    # Install the packages I find helpful for Fedora
    sudo dnf install -y git tmux wget vim-X11 vim nmap i3 \
                     i3status zsh python-pip openssl openssl-devel \
                     zlib-devel python-pep8 gcc \
                     ruby-devel gcc-c++ dkms rubygem-bundler
    sudo pip install --upgrade pip
}

del_useless_dirs()
{
    # Removes default dirs that I have no use for
    rm -rf ~/Videos ~/Templates ~/Public ~/Music ~/Desktop
}

# If executed with no options
if [ $# -eq 0 ]; then
    usage
    exit $EX_USAGE
fi

while getopts ":hcCztvg3rfu" opt; do
    case "$opt" in
        h)
            # Help message
            usage
            exit $EX_OK
            ;;
        c)
            # Clone configuration files
            clone_dotfiles
            ;;
        C)
            # Install Google Chrome
            install_chrome
            ;;
        z)
            # Install and setup ZSH shell
            install_zsh
            ;;
        t)
            # Install and setup tmux terminal multiplexer
            install_tmux
            ;;
        v)
            # Install and setup vim editor
            install_vim
            ;;
        g)
            # Setup Git version control
            install_git
            ;;
        3)
            # Setup i3 config
            install_i3
            ;;
        r)
            # Apply some of this config to the root user
            setup_root
            ;;
        f)
            # Install packages for Fedora
            fedora_packages
            ;;
        u)
            # TODO: Update - Delete dirs I have no use for
            del_useless_dirs
            ;;
        *)
            # All other flags fall through to here
            usage
            exit $EX_USAGE
    esac
done
