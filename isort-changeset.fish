# Defined in - @ line 1
function isort-changeset --wraps='git-files' --description 'alias isort-changeset=isort -y (git-files $argv | grep "\.py$")'
  set files (git-files $argv | grep '\.py$');
  set_color -o white;
  echo -n isort:
  set_color normal;
  if not test $files[1]
    echo ' Skipping (no .py files in changeset)'
    echo ''
    return 0
  end
  set result (isort -y $files | awk '{print $0, "##"}');
  if test $result[1]
    echo ''
    string split '##' $result | grep -v -e '^$'
    echo ''
    return 1
  else
    echo ' ok'
    echo ''
    return 0
  end
end
