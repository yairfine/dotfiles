#!/usr/bin/env sh

DOTFILES_DIT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

stow_dotfiles() {
    if ! command -v stow 2 >&1 >/dev/null; then
        echo "stow could not be found"
        exit 1
    fi

    echo "INSTALLING ENVIRONMENT FILES TO HOME DIR"
    stow -S sh -S bash -S zsh -S clang-format -S macos
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    stow_dotfiles
    $DOTFILES_DIT/git-configure.sh
else
    read -p "This may overwrite existing dotfiles in your home directory. Are you sure? (y/N) "
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        stow_dotfiles
        $DOTFILES_DIT/git-configure.sh
    fi
fi
unset stow_dotfiles

source $HOME/.zshrc

echo "Done, now run the following command:"
echo "source $HOME/.zshrc"
