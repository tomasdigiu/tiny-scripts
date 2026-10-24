:: Archivos necesarios en PATH o en el directorio actual: ffmpeg.exe ffprobe.exe gifski.exe

@Echo off
setlocal

del /S /Q "%temp%\gifski_sequence\*"

where ffmpeg>nul 2>&1 || (
	ECHO Missing ffmpeg from PATH. Exiting...
	EXIT /B 1
)

where gifski>nul 2>&1 || (
	ECHO Missing gifski from PATH. Exiting...
	EXIT /B 1
)

where ffprobe>nul 2>&1 || (
	ECHO Missing ffprobe from PATH. Can't read dimensions/fps.
	PAUSE
)

IF "%~1"=="" (
	ECHO Missing input argument. Usage: gif ^<input^>
	EXIT /B 1
)

:: Muestra dimensiones y fps
ffprobe -v error -select_streams v:0 -show_entries stream=width,height,r_frame_rate -of csv=s=x:p=0 "%~1" 2>NUL

SET /p output=Enter Output Filename:
SET /p fps=Enter FPS (default=15): 
SET /p max_size=Enter width/height (only the largest, default=600): 
SET /p ffmpeg_options=Enter FFmpeg Options: 
SET /p gifski_options=Enter Gifski Options: 

IF "%output%"=="" SET "output=%~n1"
IF "%fps%"=="" SET "fps=15"
IF "%max_size%"=="" SET "max_size=600"

mkdir %temp%\gifski_sequence 2>nul

ffmpeg.exe -i "%~1" -vf "fps=%fps%,scale=%max_size%:%max_size%:force_original_aspect_ratio=decrease" %ffmpeg_options% "%temp%\gifski_sequence\frame%%04d.png"

gifski.exe -r %fps% %gifski_options% -o "%output%.gif" "%temp%\gifski_sequence\frame*.png"

del /S /Q "%temp%\gifski_sequence\*"

Echo Complete!
pause

endlocal