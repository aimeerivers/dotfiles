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
    printf "Homebrew not found, installing."
    # install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # set path
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # sudo softwareupdate --install-rosetta

  printf "Installing homebrew packages..."
  brew bundle
}

activate_symlinks() {
  # vscode
  ln -sf $HOME/.dotfiles/visual-studio-code/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
}

install_oh_my_zsh_plugins() {
  for plugin in zsh-syntax-highlighting zsh-completions zsh-autosuggestions; do
    echo ${plugin}
    if [ ! -d $HOME/.oh-my-zsh/plugins/${plugin} ]; then
      git clone git@github.com:zsh-users/${plugin}.git $HOME/.oh-my-zsh/plugins/${plugin}
    else
      cd $HOME/.oh-my-zsh/plugins/${plugin}
      git pull
    fi
  done
}

printf "🛠  Installing Xcode Command Line Tools\n"
build_xcode

printf "🍺  Installing Homebrew packages\n"
install_brew

printf "🐗  Stow dotfiles\n"
stow zsh git

printf "⚡️  Activate extra symlinks\n"
activate_symlinks

printf "😲  Install/update oh my zsh plugins\n"
install_oh_my_zsh_plugins

printf "✨  Done!\n"
