:: Archivos necesarios en PATH o en el directorio actual: ffmpeg.exe ffprobe.exe gifski.exe

@Echo off
setlocal

del /S /Q "%temp%\gifski_sequence\*"

where ffmpeg>nul 2>&1 || (
	ECHO No se encuentra ffmpeg.exe en el directorio actual ni en PATH.
	ECHO Saliendo...
	EXIT /B
)

where gifski>nul 2>&1 || (
	ECHO No se encuentra gifski.exe en el directorio actual ni en PATH.
	ECHO Saliendo...
	EXIT /B
)

where ffprobe>nul 2>&1 || (
	ECHO No se encuentra ffprobe.exe en el directorio actual ni en PATH.
	ECHO No se leerán las dimensiones ni fps del video.
	PAUSE
)

IF "%~1"=="" (
	ECHO Error. Uso: gif ^<input^>
	EXIT /B
)

:: Muestra dimensiones y fps
ffprobe -v error -select_streams v:0 -show_entries stream=width,height,r_frame_rate -of csv=s=x:p=0 "%~1" 2>NUL

SET /p output=Nombre del gif ^(default = %~n1^): 
SET /p fps=FPS de salida (default = 15): 
SET /p max_size=Dimensiones de ancho/largo (solo el mas largo, default = 600): 
SET /p ffmpeg_options=Opciones extra de ffmpeg: 
SET /p gifski_options=Opciones extra de gifski: 

IF "%output%"=="" SET "output=%~n1"
IF "%fps%"=="" SET "fps=15"
IF "%max_size%"=="" SET "max_size=600"

mkdir %temp%\gifski_sequence 2>nul

ffmpeg.exe -i "%~1" -vf "fps=%fps%,scale=%max_size%:%max_size%:force_original_aspect_ratio=decrease" %ffmpeg_options% "%temp%\gifski_sequence\frame%%04d.png"

gifski.exe -r %fps% %gifski_options% -o "%output%.gif" "%temp%\gifski_sequence\frame*.png"

del /S /Q "%temp%\gifski_sequence\*"

Echo Completado!
pause

endlocal