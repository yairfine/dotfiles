# Load dotfiles:
for file in $HOME/.{exports,alias,functions,zsh_prompt,activate_brew}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
