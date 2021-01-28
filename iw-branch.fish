# Defined in - @ line 1
function iw-branch --wraps git --description 'alias iw-branch=git checkout -b'
  set branch_prefix (git config --get custom.branch-prefix)
  set branch_name $argv[1]
  set arg_count (count $argv)
  if test $arg_count -gt 1
    set extra_args $argv[2..$arg_count]
  end
  set source_branch $argv[2]
  string length -q -- $source_branch; or set source_branch "master"
  git checkout $source_branch
  git pull
  git checkout -b $branch_prefix$branch_name $extra_args
end
