# Defined in - @ line 1
function git-sync --description 'git push, setting origin if it is not already set'
  set cur_branch (git-curbranch);
  set target_branch $argv
  string length -q -- $target_branch; or set target_branch "master"
  echo Syncing $cur_branch to $target_branch...

  git checkout $target_branch
  git pull
  git checkout $cur_branch
  git rebase $target_branch
end
