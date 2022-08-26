function __git_prompt --description 'Prints info about .git repo'
  set --query PROMPT_GIT_UNTRACKED_SIGN || set --local PROMPT_GIT_UNTRACKED_SIGN (set_color brred)'✘'(set_color normal)
  set --query PROMPT_GIT_STAGED_SIGN || set --local PROMPT_GIT_STAGED_SIGN (set_color brgreen)'✔'(set_color normal)

  set --query PROMPT_GIT_INCOMING_SIGN || set --local PROMPT_GIT_INCOMING_SIGN '⬇️ '
  set --query PROMPT_GIT_OUTCOMING_SIGN || set --local PROMPT_GIT_OUTCOMING_SIGN '⬆️ '

  set --query PROMPT_GIT_DETACHED_HEAD_SIGN || set --local PROMPT_GIT_DETACHED_HEAD_SIGN (set_color brred)'⌥!'(set_color normal)

  set --local IS_INSIDE_WORK_TREE (git rev-parse --is-inside-work-tree 2> /dev/null)
  if test $status -ne 0 || test "$IS_INSIDE_WORK_TREE" = 'false'
    return
  end 

  # Check branch state
  set --local branch (git branch --show-current)
  ! set --query branch[1] && set --local branch $PROMPT_GIT_DETACHED_HEAD_SIGN

  # Check count of untracked and staged files
  set --local UNTRACKED_COUNT (git status --porcelain |\
    string replace --filter --regex '^\?\?\s+(.*)$' '$1' | count)
  set --local STAGED_COUNT (git status --porcelain |\
    string replace --filter --regex '^A\s+(.*)$' '$1' | count)
  
  test $UNTRACKED_COUNT -ne 0 &&
    set UNTRACKED_COUNT $PROMPT_GIT_UNTRACKED_SIGN':'$UNTRACKED_COUNT ||
    set UNTRACKED_COUNT
  test $STAGED_COUNT -ne 0 &&
    set STAGED_COUNT $PROMPT_GIT_STAGED_SIGN':'$STAGED_COUNT ||
    set STAGED_COUNT

  set --local WORKING_DIR_STATUS (string join ' ' $UNTRACKED_COUNT $STAGED_COUNT)

  # Check count of ahead and behind commits
  set --local RAW_SYNC_STATUS (git status --porcelain --branch)
  string match --regex --quiet 'ahead (?<AHEAD>\d+)' $RAW_SYNC_STATUS
  string match --regex --quiet 'behind (?<BEHIND>\d+)' $RAW_SYNC_STATUS

  set --query AHEAD && set AHEAD $PROMPT_GIT_OUTCOMING_SIGN':'$AHEAD
  set --query BEHIND && set BEHIND $PROMPT_GIT_INCOMING_SIGN':'$BEHIND

  set --local SYNC_STATUS $AHEAD' '$BEHIND

  set --local PROMPT $WORKING_DIR_STATUS $SYNC_STATUS $branch

  echo $PROMPT
end
