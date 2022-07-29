# Defined in - @ line 1
function get-pytest-file --description 'attempts to find a test file given a source file'
  while read -l file;
#    echo 'match?' (string match -r '^(\w+/)+test' $line)
    if string match -rq '^(\w+/)+test' $file
      continue
    end

    set filename (basename $file)
    if [ $filename = "__init__.py" ]
      continue
    end

    set dir (dirname $file)
    if string match -rq '^lib/' $dir
      set app (string match -r '^lib/\w+' $dir)
    else
      set app (string match -r '^\w+' $dir)
    end

    set app_len (math (string length $app) + 2)
    set file_len (string length $filename)
    set app_relative_file (string sub -s $app_len $file)
    set app_relative_file_len (string length $app_relative_file)
    set app_relative_dir_len (math $app_relative_file_len - $file_len)
    set app_relative_dir (string sub -l $app_relative_dir_len $app_relative_file)

    if [ $app_relative_dir = "migrations/" ]
      continue
    end

    set testdir "$app/test"
    set test_file "test_$filename"

#    if -z $app_relative_dir
#      # probably a "bulk" file like models.py, tasks.py, etc
#
#      set bulk_type (string sub --end -3 $filename)
#      echo "bulk_type $bulk_type"
#
#      if -d "$testdir/$bulk_type"
#        set test_discrete (ls "$PWD/$testdir/$bulk_type/" | grep -r '^test_')
#        echo "test_discrete: $test_discrete"
#
#        if string length -q $test_discrete
#          # TODO: use git diff to inspect the changed code and find classes to match
#          #       e.g. if class SomeModel is part of the diff, look for models/test_some_model.py
#          echo $test_discrete
#          continue
#        end
#
#      end
#
#    end

    set test_by_app_relative_path "$testdir/$app_relative_dir$test_file"

    if test -f $test_by_app_relative_path
      echo $test_by_app_relative_path
      continue
    end

    echo "no file: $file $testdir"

  end # while

end # function
