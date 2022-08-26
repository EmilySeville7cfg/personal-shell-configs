function delete_almost_local_branches --description 'Delete all merged feature/* and bugfix/* branches.'
  set --local default_branch (git rev-parse --abbrev-ref origin/HEAD | string replace --regex '^origin/' '')
  set --local branches (git branch --list --no-color 'feature*' 'bugfix*' \
    | string replace --regex '.{2}(.*)' '$1')
  
  git checkout $default_branch &> /dev/null

  for branch in $branches
    git branch --delete $branch
  end
end
