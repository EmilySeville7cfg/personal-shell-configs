function delete_almost_branches --argument-names token --description 'Delete all merged feature/* and bugfix/* branches.'
  fish --command 'delete_almost_local_branches' &
  fish --command "delete_almost_remote_branches $token" &
  wait
end
