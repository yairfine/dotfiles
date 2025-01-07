#!/usr/bin/env sh

DOT_FILES_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

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
    $DOT_FILES_DIR/git-configure.sh
else
    read -p "This may overwrite existing dotfiles in your home directory. Are you sure? (y/N) "
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        stow_dotfiles
        $DOT_FILES_DIR/git-configure.sh
    fi
fi
unset stow_dotfiles

source $HOME/.zshrc

echo "Done, now run the following command:"
echo "source $HOME/.zshrc"
