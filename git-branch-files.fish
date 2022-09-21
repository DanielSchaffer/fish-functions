# Defined in - @ line 1
function git-branch-files --argument-names branch
  if not test $branch
    set branch (git-parent-branch)
  end

  set files (git diff --name-status $branch... | awk '{ if (substr($1, 0, 1) == "R") { print $3 } else if ($1 != "D") { print $2 } }')

  string split ' ' $files
end
