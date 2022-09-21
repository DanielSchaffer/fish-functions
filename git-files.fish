# Defined in - @ line 1
function git-files --argument-names branch --description 'filters a set of files, defaulting to the current changeset, or the diff to master if the working directory is clean, using specified grep pattern'
  if not test $branch
    set branch (git-parent-branch)
  end
  # combine files from the current working changeset as well as branch commits
  set files (git-changeset) (git-branch-files $branch);
  string split ' ' $files | sort | uniq;
#  end
end
