function sort_downloads --description 'Move downloads to appropriate folders'
  set --local DOWNLOADS ~/Downloads
  set --local MUSIC ~/Music
  set --local VIDEOS ~/Videos
  set --local PICTURES ~/Pictures

  for f in $DOWNLOADS/*.{pcm,wav,aiff,mp3,aac,ogg,wma,flac,alac}
    mv $f $MUSIC/(basename $f)
  end

  for f in $DOWNLOADS/*.{mp4,mov,wmv,avi,avchd,fvl,f4v,swf,mkv,webm}
    mv $f $VIDEOS/(basename $f)
  end

  for f in $DOWNLOADS/*.{jpg,jpeg,gif,tiff,psd,pdf,eps,ai,indd,raw}
    mv $f $PICTURES/(basename $f)
  end  
end
