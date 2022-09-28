# Defined in - @ line 1
function git-checkout --wraps='git branch' --description 'returns the current branch' --argument-names branch_flag branch

  if [ $branch_flag = "-b" ]
    set parent (git branch --show-current)
    git checkout -b $branch
    git config --local --add "branch.$branch.parent" $parent
    return 0
  end

  if [ $branch_flag = "--prev" ]
    set cur_branch (git-curbranch)
    set parent (git config --get "branch.$cur_branch.parent")

    if not test $parent
      echo "No parent configured for $cur_branch"
      return -1
    end

    git checkout $parent

    return 0
  end

  if [ $branch_flag = "--next" ]
    set cur_branch (git-curbranch)
    set children (git config --name-only --get-regexp ^branch\..+\.parent\$ $cur_branch)

    if test (count $children) -eq 0
      echo "No children configured for $cur_branch"
      return -1
    end

    if test (count $children) -gt 1
      echo "Multiple children found:"
      for child in $children
        set child (string replace --regex ^branch\. "" $child)
        set child (string replace --regex \.parent\$ "" $child)
        echo "  $child"
      end
      return -1
    end

    set child_branch $children
    set child_branch (string replace --regex ^branch\. "" $children)
    set child_branch (string replace --regex \.parent\$ "" $child_branch)

    git checkout $child_branch
    return 0
  end

  git checkout $branch_flag
end
