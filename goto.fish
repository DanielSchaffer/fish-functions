# Defined in - @ line 1
function goto --description 'change directory to a project'
  set work_targets 'iw:instawork iw-demo:iw:scripts/dev_data_mod/demo iwm:instawork-mobile iwm-app:iwm:applicant-app iwds:design-system'

  set fmb_targets 'fmb:figure-my-bills fmb-web:fmb:web fmb-api:fmb:api fmb-deploy:fmb:terraform/env/deploy/stage'
  set dandi_targets 'dandi:dandi dandi-examples:dandi:_examples dandi-builder:dandi:builder dandi-pkg:dandi:packages/dandi dandi-pkg-contrib:dandi:packages/dandi-contrib'
  set webpack_babel_targets 'multi-target:webpack-babel-multi-target-plugin'

  set targets $work_targets $fmb_targets $dandi_targets $webpack_babel_targets

  # TODO: autocompletion suggestions

  set target_key $argv[1]
  set argv_extra $argv[2]

  set target_path ~/Workspace

  while test -n "$target_key"
    set target_pattern '\b'$target_key':([\\w\\-_\\/]+)(?:\\:([\\w\\-_\\/]+))?\b'

    set target (string match -r $target_pattern $targets)
    set entry_path $target[2]

    if test -n "$target[3]"
      set target_key $entry_path
      set entry_extra $target[3]
    else
      set -e target_key
      set target_path $target_path $entry_path
    end

  end

  if test -n "$entry_extra"
    set target_path $target_path $entry_extra
  end

  if test -n "$argv_extra"
    set target_path $target_path $argv_extra
  end


  for segment in $target_path
    cd $segment

    if test -e .nvmrc
      echo Using Node from $PWD/.nvmrc: (cat .nvmrc)
      nvm <.nvmrc
    end

    if test -e ./venv/bin/activate.fish
      echo Activating venv via $PWD/venv/bin/activate.fish
      . ./venv/bin/activate.fish
    end
  end


end
