# Defined in - @ line 1
function iw-deploy-pending --wraps 'git log' --argument-names env --description 'shows commits between environments'

  set STAGING_HEALTH_CHECK 'https://app.staging2.instawork.com/internal/health_check'
  set PROD_HEALTH_CHECK 'https://www.instawork.com/internal/health_check'

  if [ "$env" = "staging" ]
    set from (curl -s "$STAGING_HEALTH_CHECK" | jq -r '.sha')
    set to "origin/master"
  else if [ "$env" = "prod" ]
    set from (curl -s "$PROD_HEALTH_CHECK" | jq -r '.sha')
    set to (curl -s "$STAGING_HEALTH_CHECK" | jq -r '.sha')
  else
    set from master
    set to master
  end

  echo ""
  set commits (git log "$from".."$to")
  if test -z "$commits"
    echo "No pending commits"
  else
    echo "Pending commits:"
    echo ""
    git log "$from".."$to"
    echo ""
  end

  echo ""
  echo "--------------------"
  echo ""
  set migrations (git diff "$from".."$to" | grep "migrations\/\d.*\.py\$")
  if test -z "$migrations"
    echo "No pending migrations"
  else
    echo "Pending migrations:"
    echo ""
    git diff "$from".."$to" | grep "migrations\/\d.*\.py\$"
  end
  echo ""

end

