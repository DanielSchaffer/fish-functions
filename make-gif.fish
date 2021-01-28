# Defined in - @ line 1
function make-gif --argument-names 'd/delay=' 'o/output=' 's/size=' 'x/optimize=' --description 'converts a quicktime movie to a gif';
  set iphone_small '320x568'
  set iphone '375x667'
  set iphone_big '414×736'
  set iphone_x '375x812'
  set iphone_x_big '414x896'
  set android '472x840'
  set source_file $argv[1]

  if not test $source_file
    echo 'usage: make-gif filename.mov [-s 320x568]'
    echo 'recommended resolutions:'
    echo ' iPhone 5/5s: $iphone_small'
    echo ' iPhone 6/6s/7/8: $iphone'
    echo ' iPhone 6+/6s+/7+/8+: $iphone_big'
    echo ' iPhone X/XS: $iphone_x'
    echo ' iPhone XS Max/XR: $iphone_x_big'
    echo ' Android: $android'
    return 1
  end

  argparse --name=make-gif 'd/delay=' 'o/output=' 's/size=' 'x/optimize=' -- $argv
  set delay $_flag_d;
  set output $_flag_output;
  set size $_flag_size;
  set optimize $_flag_optimize;

  set palette_file $source_file.png
  set temp_file $source_file.tmp.gif

  if not test $delay
    set delay 50
  end
  if not test $optimize
    set optimize 3
  end
  if not test $output_file
    set output_file $source_file.gif
  end

  set_color -o white;
  echo -n 'Converting '
  set_color -o purple;
  echo -n $source_file
  set_color -o white;
  echo -n ' to '
  set_color -o purple;
  echo -n $output_file
  set_color normal;
  echo ':'
  echo -n '  size:      '
  if test $size
    echo $size
  else
    echo '(original source size)'
  end
  echo '  delay:    ' $delay
  echo '  optimize: ' $optimize

  echo ''
  set_color -o white;
  echo Generating palette...
  set_color normal;
  echo ffmpeg -i $source_file $size -filter_complex '[0:v] palettegen' -y $palette_file
  ffmpeg -i $source_file $size -filter_complex '[0:v] palettegen' -y $palette_file

  echo ''
  set_color -o white;
  echo Converting...
  set_color normal;
  echo ffmpeg -i $source_file $size -i $palette_file -filter_complex '[0:v][1:v] paletteuse' -y $temp_file
  ffmpeg -i $source_file $size -i $palette_file -filter_complex '[0:v][1:v] paletteuse' -y $temp_file

  echo ''
  set_color -o white;
  echo Optimizing...
  set_color normal;
  echo gifsicle --optimize=$optimize --delay=$delay --no-conserve-memory $temp_file -o $output_file
  gifsicle --optimize=$optimize --delay=$delay --no-conserve-memory $temp_file -o $output_file

  echo ''
  set_color -o white;
  echo Cleaning up...
  set_color normal;
  rm $palette_file $temp_file

  echo ''
  set_color -o white;
  echo Done.
  set_color normal;
end
