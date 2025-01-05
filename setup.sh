#!/usr/bin/env sh

DOT_FILES_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

copy_dotfiles() {
    echo "COPYING ENVIRONMENT FILES TO HOME DIR";

    for file in $DOT_FILES_DIR/.{bashrc,zshrc,exports,alias,functions,zsh_prompt,bash_prompt,clang-format,activate_brew,bash_specific}; do
        [ -r "$file" ] && [ -f "$file" ] && cp -v "$file" $HOME
    done;

    echo "export DOT_FILES_DIR=${DOT_FILES_DIR}" >> $HOME/.exports
    unset file;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	copy_dotfiles;
    $DOT_FILES_DIR/git-configure;
else
	read -p "This may overwrite existing dotfiles in your home directory. Are you sure? (y/N) ";
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		copy_dotfiles;
        $DOT_FILES_DIR/git-configure;
	fi;
fi;
unset copy_dotfiles;

source $HOME/.zshrc

read -p "Install git scripts? (y/N) "
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo ./git-scripts/install.sh
fi

chmod u+x "$DOT_FILES_DIR/git-setup-identity.sh"
if [ "$need_git_id_setup" = true ] ; then
    "$DOT_FILES_DIR/git-setup-identity.sh"
else
    read -p "Setup new Git identity? (y/N) ";
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        "$DOT_FILES_DIR/git-setup-identity.sh"
    fi;
fi;

chmod u+x "$DOT_FILES_DIR/macos.sh"
read -p "Configure MacOS defaults writes? (y/N) ";
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    "$DOT_FILES_DIR/macos.sh"
fi;


read -p "Install Homebrew? (y/N) ";
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    /bin/bash .activate_brew
fi;

chmod u+x "$DOT_FILES_DIR/installations.sh"
read -p "Install brew and pip packages? (y/N) ";
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    "$DOT_FILES_DIR/installations.sh"
fi;

chmod u+x "$DOT_FILES_DIR/install_casks.sh"
read -p "Install brew cask apps packages? (y/N) ";
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    "$DOT_FILES_DIR/install_casks.sh"
fi;

echo "Done, now run the following command:"
echo "source $HOME/.zshrc"