# Defined in - @ line 1
function lintable-files --argument-names branch
  if not test $branch
    set branch master
  end

  set files (git diff --name-status $branch | awk '{ if ($1 != "D") { print $2 } }')

  string split ' ' $files
end
