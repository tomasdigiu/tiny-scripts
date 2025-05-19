@Echo off
set /p output=Enter Output Filename (without extension):
set /p ffmpeg_options=Enter FFmpeg Options:
set /p gifski_options=Enter Gifski Options:

mkdir %temp%\gifski_sequence

ffmpeg.exe -i "%1" %ffmpeg_options% %temp%\gifski_sequence\frame%%04d.png
gifski.exe %gifski_options% -o %output%.gif %temp%\gifski_sequence\frame*.png

del /S /Q "%temp%\gifski_sequence\*"

Echo Complete!

CMD /K