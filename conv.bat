:: Archivo necesario en PATH o en el directorio actual: ffmpeg.exe

@echo off
setlocal

where ffmpeg>nul 2>&1 || (
	ECHO Missing ffmpeg from PATH. Exiting...
	EXIT /B 1
)

IF "%~1"=="" (
	ECHO Missing input argument. Usage: conv ^<input^>
	EXIT /B 1
)

SET /P tiempo_inicio=Tiempo de inicio: 
SET /P tiempo_fin=Tiempo de fin: 
SET /P codec=Codec? (default = hevc, 1 = libx264, c = copy): 
SET /P format=Extension (default = mp4, 1 = mkv): 
SET /P params=Parametros extra: 

:: Inicio y fin
IF "%tiempo_inicio%"=="" SET tiempo_inicio=0

SET "to_param="
IF NOT "%tiempo_fin%"=="" SET to_param=-to %tiempo_fin%

:: Selección de codec y formato
IF "%codec%"=="1" SET codec=libx264
IF "%codec%"=="c" SET "params=-c copy"
IF "%codec%"=="" SET codec=hevc

IF "%format%"=="1" SET format=mkv
IF "%format%"=="" SET format=mp4

:: Comando
ffmpeg -hide_banner -stats -ss %tiempo_inicio% %to_param% -i "%~1" -preset medium -c:v %codec% -c:a aac %params% "%~n1-1.%format%" -y

endlocal