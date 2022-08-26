function __create_variable --argument-names VARIABLE --description 'Creates specified variable'
  set --local NOT_VALID_VARIABLE_ERROR 1
  
  set --local VALUES $argv[2..]

  set --query PROMPT_SUCCESS_SIGN || set --local PROMPT_SUCCESS_SIGN (set_color brgreen)'✔'(set_color normal)
  set --query PROMPT_ERROR_SIGN || set --local PROMPT_ERROR_SIGN (set_color brred)'✘'(set_color normal)

  set --query PROMPT_VARIABLE_IDENTIFIER_COLOR || set --local PROMPT_VARIABLE_IDENTIFIER_COLOR (set_color brred)

  if set --query $VARIABLE
    echo -s $PROMPT_ERROR_SIGN'Can\'t create '\
      $PROMPT_VARIABLE_IDENTIFIER_COLOR\"$VARIABLE\"$RESET_COLOR' variable because '\
      $PROMPT_VARIABLE_IDENTIFIER_COLOR\"$VARIABLE\"$RESET_COLOR' already exists.' >&2
    return $NOT_VALID_VARIABLE_ERROR
  end
  
  set --universal $VARIABLE $VALUES
  echo $PROMPT_SUCCESS_SIGN'Variable '$PROMPT_VARIABLE_IDENTIFIER_COLOR\"$VARIABLE\"$RESET_COLOR\
    'successfully created.'
end

function variables_recreate --description 'Creates missing variables'
  set variables MINE_PATH "$HOME/Documents/mine"
  set --append variables WORK_PATH "$HOME/Documents/work"

  set --local errors 0
  set --local i 1
  while test $i -le (count $variables)
    __create_variable $variables[$i] $variables[(math $i + 1)]
    set errors (math $errors + $status)
    set i (math $i + 2)
  end
  
  test $errors -eq 0
  return $test
end
