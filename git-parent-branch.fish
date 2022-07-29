function git-parent-branch --description 'determines the parent branch of the current branch, if any, using git log'

  set parent_branches (git log master..HEAD~1 --format="%d" | grep "(" | awk -v RS=',' '{gsub(/[() ]/, ""); print $1 }' | grep -v "origin/")

  if test $parent_branches[1]
    echo $parent_branches[1]
  else
    echo "master"
  end

end
