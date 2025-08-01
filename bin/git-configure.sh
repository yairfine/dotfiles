#!/usr/bin/env sh

git config --global core.pager "command -v delta >/dev/null 2>&1 && delta || less"
git config --global core.editor "code --wait"
git config --global core.autocrlf "input"
git config --global core.excludesfile "~/.gitignore_global"
git config --global color.ui "auto"
git config --global help.autoCorrect "prompt"
git config --global init.defaultbranch "master"
git config --global tag.sort "-version:refname"
git config --global fetch.all "true"
git config --global fetch.prune "true"
# git config --global fetch.pruneTags "true"
git config --global push.autoSetupRemote "true"
git config --global pull.rebase "false"
git config --global diff.tool "vscode"
git config --global diff.colormoved "default"
git config --global diff.algorithm "histogram"
git config --global diff.renames "true"
git config --global diff.mnemonicPrefix "true"
git config --global commit.verbose "true"
git config --global merge.tool "vscode"
git config --global merge.conflictstyle "zdiff3"
git config --global rebase.rebaseMerges "true"
git config --global rebase.autoSquash "true"
git config --global rebase.autoStash "true"
git config --global grep.lineNumber "true"
git config --global sequence.editor "interactive-rebase-tool"
git config --global delta.navigate "true"
git config --global rerere.enabled "true"
git config --global rerere.autoupdate "true"
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
git config --global alias.l "log"
git config --global alias.logu "log \"@{upstream}\""
git config --global alias.lol "log --oneline"
git config --global alias.oneline "log --oneline"
git config --global alias.twolines "log --pretty=twolines"
git config --global alias.threelines "log --pretty=threelines"
git config --global alias.co "checkout"
git config --global alias.mnt "maintenance"
git config --global alias.root "rev-parse --show-toplevel"
git config --global alias.wt "worktree"
git config --global alias.sm "submodule"
git config --global alias.d "describe"
git config --global alias.bis "bisect"
git config --global alias.bisg "bisect good"
git config --global alias.bisb "bisect bad"
git config --global alias.br "branch"
git config --global alias.brs "branch --sort=-committerdate"
git config --global alias.tags "tag --sort=-committerdate"
git config --global alias.cl "clone --verbose --progress --recurse-submodules --shallow-submodules"
git config --global alias.pl "pull --recurse-submodules"
git config --global alias.plal "pull-all -f"
git config --global alias.cp "copy"
git config --global alias.ft "fetch --tags"
git config --global alias.clm "! clone_and_maintenance() { git cl \$1 && pushd \$(basename \$1 .git) && git mnt start && popd; }; clone_and_maintenance"
git config --global alias.chp "cherry-pick"
git config --global alias.ir "rebase --interactive --rebase-merges --autosquash --committer-date-is-author-date"
git config --global alias.conf "config --global --edit"
git config --global alias.gl "config --global --list"
git config --global alias.alias "config --get-regexp '^alias'"
git config --global alias.last "log -1 HEAD --stat"
git config --global alias.initial-commit "git rev-list --max-parents=0 --first-parent HEAD"
git config --global alias.graph "log --graph --oneline --decorate --branches --remotes --tags"
git config --global alias.grel "graph-rel"
git config --global alias.grelu "grel HEAD \"@{upstream}\""
git config --global alias.amend "commit --amend"
git config --global alias.ff "merge --ff-only"
git config --global alias.pushf "push --force-with-lease"
git config --global alias.unstage "restore --staged --progress"
git config --global alias.first-push "push -u origin HEAD"
git config --global alias.reseth "reset --hard"
git config --global alias.resetu "reset --keep \"@{upstream}\""
git config --global alias.diffu "! diffu() { git diff \$* \"@{upstream}\" ; }; diffu"
git config --global alias.pruning "! git fetch origin --prune && git gc && git prune && git prune-packed"
git config --global alias.purge "! git clean -xfd && git submodule foreach --recursive git clean -xfd && git reset --hard && git submodule foreach --recursive git reset --hard && git submodule update --init --recursive"
git config --global alias.subpurge "! git submodule foreach --recursive git clean -xfd && git submodule foreach --recursive git reset --hard && git submodule update --init --recursive"
git config --global alias.cleanlfs "lfs prune"
git config --global alias.diffbase "diff \$1...\$2"
git config --global alias.cop "! checkout_and_pull() { git co \$* && git pl; }; checkout_and_pull"
git config --global alias.cor "! checkout_and_reset() { [ ! \$# -eq 0 ] && git checkout \$* && git ft; git reset --hard \"@{upstream}\"; }; checkout_and_reset"
git config --global alias.cotag "!checkout_tag() { if [[ \$(git tag --list | grep -i \$1 | wc -l) -eq 1 ]]; then git tag --list | grep -i \$1 | xargs -I {} sh -c 'echo {}; git checkout {}' ; else echo 'Invalid tag[s]:'; git tag --list | grep -i \$1; fi }; checkout_tag"
git config --global alias.softmerge "! git merge \$1 --no-ff --no-commit"
git config --global alias.pushtags "! git push origin \$(git symbolic-ref --short HEAD) --tags"
git config --global alias.format "!format_diff() { git diff -U0 --no-color --relative \$* | clang-format-diff.py -p1 -v -i; }; format_diff"
git config --global alias.id "! git config user.name && git config user.email"
git config --global alias.tree "ls-tree -r"
git config --global alias.unpack-objs "! mv .git/objects/pack/pack-*.pack . && cat pack-*.pack | git unpack-objects -r && rm pack-*.pack"
git config --global alias.current "! git symbolic-ref --short -q HEAD || git rev-parse HEAD"
git config --global alias.keep "! git branch \$(git current)--\$(LC_TIME=en_US.UTF-8 date +'%Y-%b-%d--%H-%M')"
git config --global alias.bformat "! f() { [ ! \$# -eq 0 ] && BR=\$(git branch-format \"\$1\" \"\$2\") && git checkout \$BR ; }; f"
git config --global alias.bradar "! f() { [ ! -z \"\$1\" ] && BR=\$(git branch-format \"\$1\" \"eng/PR-\") && git checkout \$BR ; }; f"
git config --global alias.merged "! f() { [ ! -z \"\$1\" ] && git for-each-ref --merged=\"\$1\" --format='%(refname:short)' refs/heads | grep -v -w -e \"\$1\" ; }; f"
git config --global alias.showm "show --first-parent"
git config --global alias.verify "log --oneline --show-signature"
git config --global alias.contributor "! f() { git log --pretty=format: --name-only --author=\"\$@\" | grep -v '^$' | sort | uniq -c | sort -nr | awk '{ printf \" %-20s %s\\n\", \$2\"/\", \$1 }'| column -t | head -20 ; }; f"
git config --global alias.activity "! f() { git log --pretty=format:\"%ad\" --date=format:\"%Y-%m\" --author=\"\$@\" | sort | uniq -c | sort -k2 | awk '{print \$2\",\"\$1}' | (command -v termgraph >/dev/null 2>&1 && termgraph --title \"Commits History\" --color blue || cat) ; }; f"
git config --global alias.contrib "contributor"
git config --global alias.act "activity"
git config --global alias.sw "! f() { git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/ | (command -v fzf >/dev/null 2>&1 && fzf --preview 'git show --stat --color=always {-1}' --bind 'enter:become(git switch {-1})' --height 40% --layout reverse || cat) ; }; f"
git config --global alias.fadd "! f() { git status --porcelain | (command -v fzf >/dev/null 2>&1 && fzf -m --bind 'tab:toggle' --preview 'git diff --color=always \$(echo {} | cut -c4-)' | cut -c4- | xargs git add -v || cat) ; }; f"