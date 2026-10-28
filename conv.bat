:: Archivo necesario en PATH o en el directorio actual: ffmpeg.exe

@echo off
setlocal

where ffmpeg>nul 2>&1 || (
	ECHO No se encuentra ffmpeg.exe en el directorio actual ni en PATH.
	ECHO Saliendo...
	EXIT /B
)

IF "%~1"=="" (
	ECHO Error. Uso: conv ^<input^>
	EXIT /B
)

SET /P tiempo_inicio=Tiempo de inicio: 
SET /P tiempo_fin=Tiempo de fin: 
SET /P codec=Codec? (default = hevc, 1 = libx264, c = copy): 
IF "%codec%"=="c" (SET "params=-c copy" & SET "format=%~x1" & goto:codec_copy)
SET /P format=Extension (default = mp4, 1 = mkv): 
SET /P params=Parametros extra: 
:codec_copy


:: Tiempos de inicio y fin
IF "%tiempo_inicio%"=="" SET tiempo_inicio=0

IF NOT "%tiempo_fin%"=="" SET to_param=-to %tiempo_fin%


:: Selección de codec y formato de archivo
IF "%codec%"=="1" SET codec=libx264
IF "%codec%"=="" SET codec=hevc

IF "%format%"=="1" SET format=mkv
IF "%format%"=="" SET format=mp4
SET "format=%format:.=%" & 	rem String Substitution: . -> blank
							rem Escribir .mp4 y mp4 es lo mismo


:: Asignación de ID para el output
SET output_template="%~dpn1-#.%format%"

setlocal EnableDelayedExpansion
	for /L %%G in (1,1,99) do (
		set output_file=!output_template:#=%%G!
		if not exist !output_file! goto :continue
	)
	:continue
setlocal DisableDelayedExpansion

:: Ejecución del comando
ffmpeg -hide_banner -stats -ss %tiempo_inicio% %to_param% -i "%~1" -preset medium -c:v %codec% -c:a aac %params% %output_file% || pause

endlocal