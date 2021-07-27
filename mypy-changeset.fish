# Defined in - @ line 1
function mypy-changeset --wraps='git-files' --description 'alias mypy-changeset=mypy (git-files $argv | grep \.py$)'
  set files (git-files $argv | grep '\.py$');
  set_color -o white;
  echo -n mypy:
  set_color normal;
  if not test $files[1]
    echo ' Skipping (no .py files in changeset)'
    echo ''
    return 0
  end
  set result (mypy $files | awk '{print $0, "##"}');
  if test $result[1]
    echo ''
    if test (string match --regex '^Success' $result)
      string split '##' $result
      return 0
    else
      set_color red;
      string split '##' $result | grep -v -e '^$' 1>&2
      set_color normal;
      return 1
    end
  else
    echo ' ok'
    echo ''
    return 0
  end
end
