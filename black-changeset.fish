# Defined in - @ line 1
function black-changeset --wraps='git-files' --description 'alias black-changeset=black (git-files $argv | grep "\.py")'
  set files (git-files $argv | grep "\.py");
  set_color -o white;
  echo -n black:
  set_color normal;
  if not test $files[1]
    echo ' Skipping (no .py files in changeset)'
    echo ''
    return 0
  end
  set result (black $files | awk '{print $0, "##"}');
  if test $result[1]
    echo ''
    set_color red;
    string split '##' $result | grep -v -e '^$' 1>&2
    set_color normal;
    echo ''
    return 1
  else
    echo ' ok'
    echo ''
    return 0
  end
end
