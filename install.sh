build_xcode() {
  if ! xcode-select --print-path &>/dev/null; then
    xcode-select --install &>/dev/null

    until xcode-select --print-path &>/dev/null; do
      sleep 5
    done

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

    sudo xcodebuild -license
  fi
}

install_brew() {
  if ! command -v "brew" &>/dev/null; then
    printf "\nHomebrew not found, installing."
    # install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # set path
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # sudo softwareupdate --install-rosetta

  printf "\nInstalling homebrew packages..."
  brew bundle
}

install_additional_brew() {
  for plugin in home work; do
    read -p "Do you want to install Homebrew packages from the '${plugin}' profile? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      brew bundle --file=Brewfile.${plugin}
    fi
  done
}

install_npm_packages() {
  npm install -g commitizen cz-conventional-changelog fixpack
}

activate_symlinks() {
  # vscode
  ln -sf $HOME/.dotfiles/visual-studio-code/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
}

install_oh_my_zsh() {
  if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
}

install_oh_my_zsh_plugins() {
  for plugin in zsh-syntax-highlighting zsh-completions zsh-autosuggestions; do
    echo ${plugin}
    if [ ! -d $HOME/.oh-my-zsh/plugins/${plugin} ]; then
      git clone git@github.com:zsh-users/${plugin}.git $HOME/.oh-my-zsh/plugins/${plugin}
    else
      cd $HOME/.oh-my-zsh/plugins/${plugin}
      git pull
      cd -
    fi
  done
}

printf "\n🛠 Install Xcode Command Line Tools\n"
build_xcode

printf "\n🍺 Install Homebrew packages\n"
install_brew

printf "\n🎹 Install global npm packages\n"
install_npm_packages

printf "\n🐗 Stow dotfiles\n"
stow --dotfiles zsh git commitizen fixpack

printf "\n😲 Install oh my zsh\n"
install_oh_my_zsh

printf "\n😲 Install/update oh my zsh plugins\n"
install_oh_my_zsh_plugins

printf "\n🔌 Configure iTerm2\n"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.dotfiles/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

printf "\n🔗 Activate extra symlinks\n"
activate_symlinks

printf "\n🍺 Install additional Homebrew packages\n"
install_additional_brew

printf "\n✨ Done!\n"
