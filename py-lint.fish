# Defined in - @ line 1
function py-lint --description 'runs all lint operations on the specified set of files, defaulting to the current changeset'
  if not string match "/venv/" (which python)
    venv
  end
  set exit_code 0

  black-changeset $argv;
  set last_status $status
  if test $last_status -ne 0
    set exit_code $last_status
  end

  flake-changeset $argv;
  set last_status $status
  if test $last_status -ne 0
    set exit_code $last_status
  end

  isort-changeset $argv;
  set last_status $status
  if test $last_status -ne 0
    set exit_code $last_status
  end

  mypy-changeset $argv;
  set last_status $status
  if test $last_status -ne 0
    set exit_code $last_status
  end

  prettier-changeset $argv;
  set last_status $status
  if test $last_status -ne 0
    set exit_code $last_status
  end

  return $exit_code
end
