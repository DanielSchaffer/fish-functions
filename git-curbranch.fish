# Defined in - @ line 1
function git-curbranch --wraps='git branch --show-current' --description 'returns the current branch'
  git branch --show-current;
end
