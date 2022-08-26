function __cwd_prompt --description 'Prints $PWD in human-readable format'
  set --local directory $PWD

  set --local directory (__transform_path $directory)
  set --local directory (__colorize_path $directory)

  echo $directory
end
