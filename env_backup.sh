#! /bin/sh -e

DOT_FILES_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo copying environment to $DOT_FILES_DIR

for file in $HOME/.{zshrc,exports,alias,functions,zsh_prompt,gitconfig,clang-format}; do
    [ -r "$file" ] && [ -f "$file" ] && cp "$file" "$DOT_FILES_DIR";
done;
unset file;
