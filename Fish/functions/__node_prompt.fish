function __node_prompt --description 'Prints info about Node version'
  set --query PROMPT_NODE_IDENTIFIER_COLOR || set --local PROMPT_NODE_IDENTIFIER_COLOR (set_color brgreen)
  set --query PROMPT_NODE_VERSION_COLOR || set --local PROMPT_NODE_VERSION_COLOR (set_color green)

  set --query PROMPT_NODE_SIGN || set --local PROMPT_NODE_SIGN (set_color green)'❰'(set_color normal)

  set --local CURRENT_DIR $PWD
  set --local not_found $TRUE

  set metadata (find -maxdepth 1 -type f -name 'package.json' -print0 | string split0)
  while ! set --query metadata[1]
    if test $PWD != '/'
      cd ..
      set metadata (find -maxdepth 1 -type f -name 'package.json' -print0 | string split0)
    else
      set not_found $FALSE
      break
    end
  end

  if test $not_found -eq $FALSE
    cd $CURRENT_DIR
    return
  end

  set --local PROMPT $PROMPT_NODE_SIGN

  if command --query --search node
    set --local NODE_VERSION (node --version)
    string match --regex --quiet '^v(?<MAJOR_VERSION>\d+)\.(?<MINOR_VERSION>\d+).*' $NODE_VERSION
    set PROMPT $PROMPT$PROMPT_NODE_IDENTIFIER_COLOR'node '$PROMPT_NODE_VERSION_COLOR$MAJOR_VERSION.$MINOR_VERSION(set_color normal)
  else
    set PROMPT
  end

  echo -n $PROMPT
  cd $CURRENT_DIR
end
