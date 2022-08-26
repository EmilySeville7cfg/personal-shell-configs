function __pipestatus_prompt --description 'Prints $pipestatus in human-readable format'
  set --local STATUSES $argv

  set --query PROMPT_PIPESTATUS_BRACKET_COLOR || set --local PROMPT_PIPESTATUS_BRACKET_COLOR (set_color red)
  set --query PROMPT_PIPESTATUS_STATUS_COLOR || set --local PROMPT_PIPESTATUS_STATUS_COLOR (set_color brred)
  set --query PROMPT_PIPESTATUS_DELIMITER_COLOR || set --local PROMPT_PIPESTATUS_DELIMITER_COLOR (set_color purple)

  set --local zero_status $TRUE
  for i in (seq 1 (count $STATUSES))
    if test $STATUSES[$i] != 0
      set zero_status $FALSE
      break
    end
  end

  test $zero_status = $TRUE && return

  echo -n $PROMPT_PIPESTATUS_BRACKET_COLOR'['

  for i in (seq 1 (count $STATUSES))
    echo -n $PROMPT_PIPESTATUS_STATUS_COLOR$STATUSES[$i]
    test $i -lt (count $STATUSES) && echo -n $PROMPT_PIPESTATUS_DELIMITER_COLOR'|'
  end

  echo -n $PROMPT_PIPESTATUS_BRACKET_COLOR']'(set_color normal)
end
