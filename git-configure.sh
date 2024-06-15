#!/usr/bin/env sh

git config --global core.pager "command -v delta >/dev/null 2>&1 && delta || less"
git config --global core.editor "code --wait"
git config --global core.autocrlf "input"
git config --global core.excludesfile "~/.gitignore_global"
git config --global color.ui "auto"
git config --global init.defaultbranch "master"
git config --global pull.rebase "false"
git config --global diff.tool "vscode"
git config --global diff.colormoved "default"
git config --global merge.tool "vscode"
git config --global merge.conflictstyle "diff3"
git config --global sequence.editor "interactive-rebase-tool"
git config --global delta.navigate "true"
git config --global rerere.enabled "true"
git config --global column.branch "auto"
git config --global column.tag "auto"
git config --global http.sslverify "false"
git config --global filter.lfs.clean "git-lfs clean -- %f"
git config --global filter.lfs.smudge "git-lfs smudge -- %f"
git config --global filter.lfs.process "git-lfs filter-process"
git config --global filter.lfs.required "true"
git config --global difftool.sourcetree.cmd "opendiff \"\$LOCAL\" \"\$REMOTE\""
git config --global difftool.sourcetree.path ""
git config --global difftool.vscode.cmd "code --wait --diff \$LOCAL \$REMOTE"
git config --global mergetool.sourcetree.cmd "/Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh \"\$LOCAL\" \"\$REMOTE\" -ancestor \"\$BASE\" -merge \"\$MERGED\""
git config --global mergetool.sourcetree.trustexitcode "true"
git config --global mergetool.bc3.trustexitcode "true"
git config --global mergetool.vscode.cmd "code --wait \$MERGED"
git config --global pretty.twolines "format: %C(auto)%h%C(reset)%C(auto)%d%C(reset) %C(white)%s%C(reset)  %C(dim white)%an%C(reset) %n"
git config --global pretty.threelines "format: %C(auto)%h%C(reset)%C(auto)%d%C(reset) %n %C(white)%s%C(reset)  %C(dim white)%an%C(reset) %n"
git config --global alias.s "status --short"
git config --global alias.sb "status --short --branch"
git config --global alias.st "status"
git config --global alias.cm "commit"
git config --global alias.co "checkout"
git config --global alias.br "branch"
git config --global alias.brs "branch --sort=-committerdate"
git config --global alias.cl "clone --verbose --progress --recurse-submodules --shallow-submodules"
git config --global alias.chp "cherry-pick"
git config --global alias.grep "grep --line-number"
git config --global alias.ir "rebase --interactive --rebase-merges --autosquash --committer-date-is-author-date"
git config --global alias.conf "config --global --edit"
git config --global alias.gl "config --global --list"
git config --global alias.alias "config --get-regexp '^alias'"
git config --global alias.last "log -1 HEAD --stat"
git config --global alias.graph "log --graph --oneline --decorate --branches --remotes --tags"
git config --global alias.amend "commit --amend"
git config --global alias.pushf "push --force-with-lease"
git config --global alias.unstage "restore --staged --progress"
git config --global alias.first-push "push -u origin HEAD"
git config --global alias.reseth "reset --hard \"@{upstream}\""
git config --global alias.pruning "! git fetch origin --prune && git gc && git prune && git prune-packed"
git config --global alias.purge "! git clean -xfd && git submodule foreach --recursive git clean -xfd && git reset --hard && git submodule foreach --recursive git reset --hard && git submodule update --init --recursive"
git config --global alias.subpurge "! git submodule foreach --recursive git clean -xfd && git submodule foreach --recursive git reset --hard && git submodule update --init --recursive"
git config --global alias.cleanlfs "lfs prune"
git config --global alias.diffbase "diff \$1...\$2"
git config --global alias.cop "!checkout_and_pull() { git checkout \$* && git pull; }; checkout_and_pull"
git config --global alias.cotag "!checkout_tag() { if [[ \$(git tag --list | grep -i \$1 | wc -l) -eq 1 ]]; then git tag --list | grep -i \$1 | xargs -I {} sh -c 'echo {}; git checkout {}' ; else echo 'Invalid tag[s]:'; git tag --list | grep -i \$1; fi }; checkout_tag"
git config --global alias.softmerge "! git merge \$1 --no-ff --no-commit"
git config --global alias.pushtags "! git push origin \$(git symbolic-ref --short HEAD) --tags"
git config --global alias.format "!format_diff() { git diff -U0 --no-color --relative \$* | clang-format-diff.py -p1 -v -i; }; format_diff"
git config --global alias.id "! git config user.name && git config user.email"
git config --global alias.tree "ls-tree -r"
git config --global alias.unpack-objs "! mv .git/objects/pack/pack-*.pack . && cat pack-*.pack | git unpack-objects -r && rm pack-*.pack"
git config --global alias.find-merge "! sh -c 'commit=\$0 && branch=\${1:-HEAD} && (git rev-list \$commit..\$branch --ancestry-path | cat -n; git rev-list \$commit..\$branch --first-parent | cat -n) | sort -k2 -s | uniq -f1 -d | sort -n | tail -1 | cut -f2' "
git config --global alias.show-merge "! sh -c 'merge=\$(git find-merge \$0 \$1) && [ -n \"\$merge\" ] && git show \$merge' "
git config --global alias.current "! git symbolic-ref --short -q HEAD || git rev-parse HEAD"
git config --global alias.keep "! git tag \$(git current)-\$(date -Idate)"
