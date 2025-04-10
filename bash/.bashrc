# Load dotfiles:
for file in $HOME/.{env,exports,alias,functions,bash_prompt,activate_brew,bash_specific}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

alias reload="source ~/.bashrc"
