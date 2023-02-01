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

  sudo softwareupdate --install-rosetta

  printf "Installing homebrew packages..."
  brew bundle
}

printf "🛠  Installing Xcode Command Line Tools\n"
build_xcode

printf "🍺  Installing Homebrew packages\n"
install_brew

# printf "🐗  Stow dotfiles\n"
# stow git zsh

printf "✨  Done!\n"
