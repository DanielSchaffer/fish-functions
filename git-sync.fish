# Defined in - @ line 1
function git-sync --description 'git push, setting origin if it is not already set' --argument-names auto
  set cur_branch (git-curbranch);
  string length -q -- $target_branch; or set target_branch (git-parent-branch)
  echo Syncing $cur_branch to $target_branch...

  git checkout $target_branch
  git pull
  git checkout $cur_branch
  git rebase $target_branch

  if [ "$auto" = "--auto" ]
    git-checkout --next

    while test $status -eq 0
      git rebase (git-parent-branch) && git push -f && git-checkout --next
    end
  end
end
