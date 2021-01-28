# Defined in - @ line 1
function pytest-files --description 'gets a set of probable test files to use with pytest based on files in the current git diff'
  set source_files (git-files $argv | grep "\.py" | grep -v '/test/test_' | get-pytest-file);
  if not test source_files[1]
    return 0
  end

  string split ' ' $source_files
end
