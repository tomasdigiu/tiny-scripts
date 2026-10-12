@Echo off
setlocal

ffprobe "%~1"
SET /p output=Enter Output Filename:
SET /p fps=Enter FPS: 
SET /p max_size=Enter width/height: 
SET /p ffmpeg_options=Enter FFmpeg Options: 
SET /p gifski_options=Enter Gifski Options: 

IF "%output%"=="" SET "output=%~n1"

mkdir %temp%\gifski_sequence

ffmpeg.exe -i "%~1" -vf "fps=%fps%,scale=%max_size%:%max_size%:force_original_aspect_ratio=decrease" %ffmpeg_options% "%temp%\gifski_sequence\frame%%04d.png"

gifski.exe -r %fps% %gifski_options% -o "%output%.gif" "%temp%\gifski_sequence\frame*.png"

del /S /Q "%temp%\gifski_sequence\*"

Echo Complete!
pause

endlocal