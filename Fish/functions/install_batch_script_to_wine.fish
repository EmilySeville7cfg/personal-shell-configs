function install_batch_script_to_wine --description 'Copy all .bat/.awk files to Wine Configs folder'
  for file in *.bat *.awk
    cp --force $file "$HOME/.wine/dosdevices/c:/Program Files (x86)/Configs/$file"
  end
end
