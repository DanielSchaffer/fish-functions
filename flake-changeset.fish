# Defined in - @ line 1
function flake-changeset --wraps='git-files' --description 'alias flake-changeset=flake8 (git-files $argv | grep "\.py")'
  set files (git-files $argv | grep "\.py");
  set_color -o white;
  echo -n flake8:
  set_color normal;
  if not test $files[1]
    echo ' Skipping (no .py files in changeset)'
    echo ''
    return 0
  end
  set result (flake8 $files | awk '{print $0, "##"}');
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
