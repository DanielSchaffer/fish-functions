# Defined in - @ line 1
function git-changeset --wraps='grep' --description 'list git status files matching the specified grep pattern'
  # if $1 != "D"   // ignore deleted files
  # if $4 print $4 // renamed files - only report the new name
  # else print $2  // other normally modified files
  set files (git status -s -u | awk '{ if ($1 != "D") { if ($4) { print $4 } else { print $2 } } }')
  if test $argv
    files = $files | grep $argv
  end
  string split ' ' $files;
end
