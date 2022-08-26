function fish_prompt
  set --local STATUSES $pipestatus

  set --query PROMPT_ERROR_SIGN || set --local PROMPT_ERROR_SIGN (set_color brred)'✘'(set_color normal)

  set --query PROMPT_PATH_COLOR || set --local PROMPT_PATH_COLOR (set_color brred)

  set --local user_char '💲'
  fish_is_root_user && set user_char '⭐💲'

  if ! set --query MINE_PATH WORK_PATH
    echo -sn $PROMPT_ERROR_SIGN'Can\'t show correct prompt because any of the following variables are undefined: '\
      $PROMPT_PATH_COLOR\"MINE_PATH\"$RESET_COLOR','\
      $PROMPT_PATH_COLOR\"WORK_PATH\"$RESET_COLOR $user_char
    return
  end

  echo -s (set_color yellow) (__cwd_prompt) ' '(__git_prompt) ' '(__net_prompt) ' '(__node_prompt)\
    ' '(__date_prompt) (__pipestatus_prompt $STATUSES) $user_char
end
