# Defined in - @ line 1
function git-diff --wraps='git diff --name-only' --argument-names pattern ignore-changeset --description 'list files changes for the specified commits, or the current changeset'
  set files (git diff --name-only $argv)
  if not test $ignore-changeset
    set files $files (git-changeset)
  end
  if test $pattern
    set files $files | grep $pattern
  end
  string split ' ' $files | grep -v -e '^$' | uniq | sort
end
