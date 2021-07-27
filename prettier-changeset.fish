# Defined in - @ line 1
function prettier-changeset --wraps='git-files' --description 'alias mypy-changeset=mypy (git-files $argv | grep -E \.(js|ts)$'
  set files (git-files $argv | grep -E '\.(js|ts)$');
  set_color -o white;
  echo -n prettier:
  set_color normal;
  if not test $files[1]
    echo ' Skipping (no .js or .ts files in changeset)'
    echo ''
    return 0
  end
  set result (yarn --silent prettier $files --write --check | awk '{print $0, "##"}');
  if test $result[1]
    echo ''
    string split '##' $result | grep -v -e '^$'
    echo ''
    return
  else
    echo ' ok'
    echo ''
    return 0
  end
end
