# Defined in - @ line 1
function py-lint --description 'runs all lint operations on the specified set of files, defaulting to the current changeset'
  if not string match "/venv/" (which python)
    venv
  end
  black-changeset $argv;
  flake-changeset $argv;
  isort-changeset $argv;
  mypy-changeset $argv;
  prettier-changeset $argv;
end
