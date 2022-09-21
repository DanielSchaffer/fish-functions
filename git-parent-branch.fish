function git-parent-branch --argument-names reset_flag --description 'determines the parent branch of the current branch, if any, using git log'

  set current_branch (git-curbranch)

  if [ "$reset_flag" = "--reset" ]
    git config --unset "branch.$current_branch.parent"
  else
    set parent_branch_from_config (git config --get "branch.$current_branch.parent")
  end

  if test $parent_branch_from_config
    echo $parent_branch_from_config
    return
  end

  set parent_branches (git log master..HEAD~1 --format="%d" | grep "(" | awk -v RS=',' '{gsub(/[() ]/, ""); print $1 }' | grep -v "origin/")

  if test $parent_branches[1]
    set parent $parent_branches[1]
    git config --local --add "branch.$current_branch.parent" $parent
    echo $parent
    return
  end

  echo "master"

end
