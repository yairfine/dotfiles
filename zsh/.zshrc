# Load dotfiles:
for file in $HOME/.{env,exports,alias,functions,zsh_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
