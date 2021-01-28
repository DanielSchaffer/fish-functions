# Defined in - @ line 1
function pycharm-exclude-long-files --description 'generates a files exclusion pattern for files over a specified number of lines'
  set files (long-files | awk '{print "!file:"substr($0,3)}')
  string join "&&" $files
end
