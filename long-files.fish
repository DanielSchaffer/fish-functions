# Defined in - @ line 1
function long-files --description 'identifies files over a specified number of lines'
  find . -name '*.py' -type f -not -path 'node_modules' -not -path '*/venv/*' -not -path '*/migrations/*' -exec bash -c '[[ $(wc -l < "$1") -gt 5000 ]] && echo "$1"' _ '{}' \;
end
