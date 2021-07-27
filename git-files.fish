# Defined in - @ line 1
function git-files --description 'filters a set of files, defaulting to the current changeset, or the diff to master if the working directory is clean, using specified grep pattern'
  echo git-files $argv
  if test $argv
    string split ' ' $argv;
  else
    set files (git-changeset);
    if test $files[1]
      string split ' ' $files;
    else
      lintable-files master;
    end
  end
end
