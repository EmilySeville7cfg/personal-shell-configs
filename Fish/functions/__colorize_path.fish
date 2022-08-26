function __colorize_path --argument-names directory --description 'Colorizes path'
  set --query PROMPT_PATH_PATH_COLOR || set --local PROMPT_PATH_PATH_COLOR (set_color brcyan)
  set --query PROMPT_PATH_DELIMITER_COLOR || set --local PROMPT_PATH_DELIMITER_COLOR (set_color brblue)

  set --local MINE_COLOR (set_color --bold)
  set --local WORK_COLOR (set_color --bold)
  
  set --local directory (string replace --regex '(\$MINE_PATH)' $MINE_COLOR'🏠$1'(set_color normal) $directory)
  set --local directory (string replace --regex '(\$WORK_PATH)' $WORK_COLOR'🏢$1'(set_color normal) $directory)

  set --local directory $PROMPT_PATH_PATH_COLOR$directory
  set --local directory (string replace --regex --all '/' $PROMPT_PATH_DELIMITER_COLOR'/'$PROMPT_PATH_PATH_COLOR $directory)
  set --local directory $directory(set_color normal)

  echo $directory
end
