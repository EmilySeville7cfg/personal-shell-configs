function __date_prompt --description 'Prints date in human-readable format'
  set --query PROMPT_DATE_COLOR || set --local PROMPT_DATE_COLOR (set_color brgreen)
  set --query PROMPT_DATE_FORMAT || set --local PROMPT_DATE_FORMAT '+%a %I:%M'

  echo $PROMPT_DATE_COLOR(date $PROMPT_DATE_FORMAT)(set_color normal)
end
