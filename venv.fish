# Defined in - @ line 1
function venv --description 'activates virtualenv using the specified venv version'
  set venv_path venv;
  if test $argv[1]
    set venv_path $venv_path/$argv[1];
  end
	. ~/Workspace/instawork/$venv_path/bin/activate.fish;
end
