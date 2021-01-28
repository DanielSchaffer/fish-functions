# Defined in - @ line 1
function py-push --description 'git push, setting origin if it is not already set'
  set branch (git-curbranch)

  set_color -o white
  echo -n 'Branch '
  set_color -o purple
  echo -n $branch
  set_color -o white
  echo ' has the following changed files:'
  set_color normal
  git-files
  echo ''

  set_color -o white
  echo Linting...
  set_color normal
  echo ''
  py-lint

  if test (git status -s)
    git commit -a -m "lint"
  end

  set_color -o white
  echo Pushing...
  set_color normal
  git push --set-upstream origin (git-curbranch)
end
