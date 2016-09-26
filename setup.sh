#!/usr/bin/env sh

EX_OK=0
EX_ERR=1
EX_USAGE=64

ROOT_HOME="/root"

install_package()
{
  echo "installing $1"
  if which apt-get &>/dev/null; then
    sudo apt-get install -y $1
  elif which dnf &>/dev/null; then
    sudo dnf install -y $1
  elif which yum &>/dev/null; then
    sudo yum install -y $1
  else
    echo "package manager not found, aborting"
    exit 1
  fi
}

usage()
{
  # Print usage message
  cat << EOF
Usage $0 [options]

Setup a Linux system.

OPTIONS:
    -h Show this message
    -c Clone configuration files
    -z Install and setup ZSH shell
    -t Install and setup tmux
    -v Install and setup vim editor
    -g Setup git version control
    -3 Setup i3 config
    -d Remove the default dirs in ~ that I find useless

EOF
}

ensure_sudo()
{
  user=$(id | cut -d'=' -f2 | cut -d\( -f1)
  if [ $user -ne 0 ]; then
    echo "This option needs root authentication to install."
    exit 1
  fi
}

backup_config_file()
{
  echo "backing up $1"
  if [ -L $1 ]; then
    echo "Symlink $1 already exists, removing it"
      rm $1
    fi

  if [ -f $1 ]; then
    echo "$1 already exists, moving it to $1.bak"
      mv $1 "$1.bak"
    fi
}

clone_dotfiles()
{
  # Grab repo of Linux configuration files
  if ! command -v git &> /dev/null; then
    install_package git
  fi
  if [ ! -d $HOME/.dotfiles ]
  then
    git clone https://github.com/alexanderdean111/dotfiles.git $HOME/.dotfiles
  fi
}

install_zsh()
{
  # Install and configure ZSH. Can be used stand-alone.
  if ! command -v zsh &> /dev/null; then
    install_package zsh
  fi

  # link config
  clone_dotfiles
  backup_config_file $HOME/.zshrc
  echo "Creating symlink: $HOME/.zshrc"
  ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc

  # Grab general ZSH config via oh-my-zsh project
  # See https://github.com/robbyrussell/oh-my-zsh
  if ! git clone https://github.com/robbyrussell/oh-my-zsh.git \
          $HOME/.oh-my-zsh &>/dev/null; then
    echo "oh-my-zsh config already exists, leaving as is"
  fi

  # Set ZSH as my default shell
  if ! chsh -s `command -v zsh`; then
    echo "chsh failed, zsh not set as default shell"
    # modifying bash_profile like this breaks login in some weird way
    #echo "chsh failed, symlinking .bash_profile instead"
    #backup_config_file $HOME/.bash_profile
    #echo "Creating symlink: $HOME/.bash_profile"
    #ln -s $HOME/.dotfiles/bash_profile $HOME/.bash_profile
  fi
}

install_tmux()
{
  if ! command -v tmux &> /dev/null; then
    install_package tmux
  fi

  # link config
  clone_dotfiles
  backup_config_file $HOME/.tmux.conf
  echo "Creating symlink: $HOME/.tmux.conf"
  ln -s $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
}

install_vim()
{
  # install Vundle
  echo "installing Vundle"
  ret=$(git clone https://github.com/VundleVim/Vundle.vim.git \
    $HOME/.dotfiles/vim/bundle/Vundle.vim 2>&1)
  if [[ "$ret" =~ "already exists" ]]; then
    echo "Vundle already installed, skipping"
  fi
  # link config
  backup_config_file $HOME/.vim
  echo "Creating symlink: $HOME/.vim"
  ln -s $HOME/.dotfiles/vim $HOME/.vim
  
  if ! command -v vim &> /dev/null; then
    install_package vim-minimal
    install_package vim-X11
    install_package vim
    install_package vim-enhanced
  fi
  # link config
  clone_dotfiles
  backup_config_file $HOME/.vimrc
  echo "Creating symlink: $HOME/.vimrc"
  ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc
}

install_git()
{
  clone_dotfiles
  backup_config_file $HOME/.gitconfig
  echo "Creating symlink: $HOME/.vimrc"
  ln -s $HOME/.dotfiles/gitconfig $HOME/.gitconfig
}

install_i3()
{
  # Install i3 WM if it isn't already installed
  if ! command -v i3 &> /dev/null; then
    install_package i3
  fi

  # Install i3status, used by i3 WM, if it isn't already installed
  if ! command -v i3status &> /dev/null; then
    install_package i3status
  fi

  # Install feh, if it isn't already installed
  if ! command -v feh &> /dev/null; then
    install_package feh 
  fi

  # Clone configs, including i3 and i3status configurations
  clone_dotfiles

  # Create required dir for i3 config, if it doesn't exist
  # otherwise, back it up
  if [ ! -d $HOME/.i3 ]
  then
    mkdir $HOME/.i3
  fi

  # link config
  backup_config_file $HOME/.i3/config
  echo "Creating symlink: $HOME/.i3/config"
  ln -s $HOME/.dotfiles/i3_config $HOME/.i3/config

  # link i3status config
  backup_config_file $HOME/.i3status.conf
  echo "Creating symlink: $HOME/.i3status.conf"
  ln -s $HOME/.dotfiles/i3status.conf $HOME/.i3status.conf
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

while getopts ":hcztvg3rd" opt; do
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
    d)
      del_useless_dirs
      ;;
    *)
      # All other flags fall through to here
      usage
      exit $EX_USAGE
  esac
done
