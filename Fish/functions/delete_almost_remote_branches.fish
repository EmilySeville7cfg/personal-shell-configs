function delete_almost_remote_branches --argument-names token --description 'Delete all merged feature/* and bugfix/* branches.'
  set --local owner (git remote get-url origin \
    | string replace --regex '^https://github.com/(.*)/.*\.git$' '$1')
  set --local repository (git remote get-url origin \
    | string replace --regex '^.*/(.*)\.git$' '$1')

  set --local branches (curl https://api.github.com/repos/$owner/$repository/branches \
    | jq --raw-output '.[].name' | string match --regex 'feature.*|bugfix.*')

  set --local user (git config user.name)
  
  for branch in $branches
    curl --silent --request DELETE --user "$user:$token" "https://api.github.com/repos/$owner/$repository/git/refs/heads/$branch"
  end
end
