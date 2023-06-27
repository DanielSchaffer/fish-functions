# Defined in - @ line 1
function git-child-branch --description 'prints the name of the child branch, if any'

  set cur_branch (git-curbranch)
  set children (git config --name-only --get-regexp ^branch\..+\.parent\$ $cur_branch\$)

  if test (count $children) -eq 0
    echo ""
    return 0
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

  echo $child_branch
  return 0
end
