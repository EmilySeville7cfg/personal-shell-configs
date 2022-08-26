function __transform_path --argument-names directory --description 'Replaces $HOME with tilde and mine/work dirs with special keywords'
  set --local directory (string replace --regex '^'$MINE_PATH '\$MINE_PATH' $directory)
  set --local directory (string replace --regex '^'$WORK_PATH '\$WORK_PATH' $directory)

  set --local directory (string replace --regex '^'$HOME '~' $directory)

  echo $directory
end
