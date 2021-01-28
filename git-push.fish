# Defined in - @ line 1
function git-push --description 'git push, setting origin if it is not already set'
  git push --set-upstream origin (git-curbranch)
end
