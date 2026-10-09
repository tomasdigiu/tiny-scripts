@Echo off
ffprobe "%~1"
set /p output=Enter Output Filename (without extension):
set /p fps=Enter FPS:
set /p width=Enter width:
set /p ffmpeg_options=Enter FFmpeg Options:
set /p gifski_options=Enter Gifski Options:

mkdir %temp%\gifski_sequence

ffmpeg.exe -i "%~1" -vf "fps=%fps%,scale=%width%:-1" %ffmpeg_options% "%temp%\gifski_sequence\frame%%04d.png"
gifski.exe -r %fps% %gifski_options% -o %output%.gif "%temp%\gifski_sequence\frame*.png"

del /S /Q "%temp%\gifski_sequence\*"

Echo Complete!
pause
