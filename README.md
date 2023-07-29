# dotfiles

## Install

Before you get started make sure you give full disk access permission to your terminal (for writing macos defaults). `System Preferences -> Privacy -> Full Disk Access`.

(på dansk `Indstillinger -> Sikkerhedsindstillinger -> Fuld adgang til disk`)

To install:

    curl -L https://raw.githubusercontent.com/aimeerivers/dotfiles/main/run.sh | sh

This expands to [run.sh](./run.sh) which will fetch this repo and run the install script.

## Fix Github access

Generate a public ssh key if you don't already have one

    cd ~/.ssh
    ssh-keygen -t rsa -b 4096 -C "mailaddress"

Copy the ssh public key to your clipboard

    pbcopy < ~/.ssh/id_rsa.pub

Enter it at https://github.com/settings/ssh/new

Test that it worked

    ssh -T git@github.com

Now you should be able to run intstall again

    cd ~/.dotfiles
    ./install.sh

## Post-install

We had to install using HTTPS. If you want to change to SSH after authenticating with Github, use the following:

    git remote remove origin
    git remote add origin git@github.com:aimeerivers/dotfiles.git

## Synthwave Themes

### iTerm2

Go to preferences -> profiles and import [iterm2/synthwave.json](./iterm2/synthwave.json)

### Visual Studio Code

Install [SynthWave '84](https://marketplace.visualstudio.com/items?itemName=RobbOwen.synthwave-vscode)

`Cmd + Shift + P` and `Enable Neon Dreams`

Install [Fix VSCode Checksums](https://marketplace.visualstudio.com/items?itemName=lehni.vscode-fix-checksums)

`Cmd + Shift + P` and `Fix Checksums: Apply`

## Rainbow Themes

### Visual Studio Code

    code --install-extension visual-studio-code/rainbow-color-theme-0.0.1.vsix

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
