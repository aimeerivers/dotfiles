# dotfiles

## Install

Before you get started make sure you give full disk access permission to your terminal (for writing macos defaults). `System Preferences -> Privacy -> Full Disk Access`.

(på dansk `Indstillinger -> Sikkerhedsindstillinger -> Fuld adgang til disk`)

To install:

    curl -L https://raw.githubusercontent.com/sermoa/dotfiles/main/run.sh | sh

This expands to [run.sh](./run.sh) which will fetch this repo and run the install script.

## Post-install

We had to install using HTTPS. If you want to change to SSH after authenticating with Github, use the following:

    git remote remove origin
    git remote add origin git@github.com:sermoa/dotfiles.git

## Make changes

    editdotfiles

This should put you in the right directory and open Visual Studio Code for you to be able to make changes.

If you update the Brewfile

    brew bundle

If you update `zsh/.zshrc` or `zsh/.aliases`

    reloadzsh

If you want to reconfigure everything

    ./install.sh
    
## Customisation

###  Git

Be sure to update the user name and email values in the global [.gitconfig](./git/.gitconfig)

### zsh theme

The zsh theme is [miloshadzic](https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/miloshadzic.zsh-theme)

## Inspiration

* [dineshraj/dotfiles](https://github.com/dineshraj/dotfiles)
