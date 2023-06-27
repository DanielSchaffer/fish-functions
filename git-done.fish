# Defined in - @ line 1
function git-done --description 'removes the current branch and returns to the parent or default branch'

  set branch (git-curbranch)

  if [ (git-parent-branch) = "master" ]
    set child_branch (git-child-branch)
    if test $child_branch
      git checkout $child_branch
      git rebase master
      git-parent-branch --reset
      return 0
    end
  end

  git-checkout --prev
  git branch -D $branch

end
