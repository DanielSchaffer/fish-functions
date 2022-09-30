# Defined in - @ line 1
function git-done --description 'removes the current branch and returns to the parent or default branch'

  set branch (git-curbranch)
  git-checkout --prev
  git branch -D $branch

end
