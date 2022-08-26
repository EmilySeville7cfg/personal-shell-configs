function git_repo_recreate --description 'Recreates repo from remote'
  set --local NO_VALID_REPO_ERROR 1

  set --query PROMPT_SUCCESS_SIGN || set --local PROMPT_SUCCESS_SIGN (set_color brgreen)'✔'(set_color normal)
  set --query PROMPT_ERROR_SIGN || set --local PROMPT_ERROR_SIGN (set_color brred)'✘'(set_color normal)

  set --query PROMPT_GIT_PATH_COLOR || set --local PROMPT_GIT_PATH_COLOR (set_color brcyan)
  set --query PROMPT_GIT_IDENTIFIER_COLOR || set --local PROMPT_GIT_IDENTIFIER_COLOR (set_color brred)

  if test ! -d .git
    echo -s $PROMPT_ERROR_SIGN'Can\'t recreate .git repo from remote because '\
      $PROMPT_GIT_PATH_COLOR\"$PWD\"$RESET_COLOR' doesn\'t contain '\
      $PROMPT_GIT_PATH_COLOR\".git\"$RESET_COLOR' folder.' >&2
    return $NO_VALID_REPO_ERROR
  end

  set --local remote (git config --get remote.origin.url)
  if set --query $remote[1]
    echo -s $PROMPT_ERROR_SIGN'Can\'t recreate .git repo from remote because '\
      $PROMPT_GIT_PATH_COLOR\"$PWD\"$RESET_COLOR' repo hasn\'t '\
      $PROMPT_GIT_IDENTIFIER_COLOR\"origin\"$RESET_COLOR' remote configured.' >&2
    return $NO_VALID_REPO_ERROR
  end

  rm -rf -- * .* &> /dev/null
  git clone $remote .
  echo $PROMPT_SUCCESS_SIGN'Repo successfully recreated from remote.'
end