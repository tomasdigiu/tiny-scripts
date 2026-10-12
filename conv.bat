@echo off

setlocal

SET /P tiempo_inicio=Tiempo de inicio:
SET /P tiempo_fin=Tiempo de fin: 
SET /P codec=Codec? (default = hevc, y = libx264)
SET /P format=Extension (default = mp4): 
SET /P params=Parametros extra: 

:: Inicio y fin
IF "%tiempo_inicio%"=="" SET tiempo_inicio=0

SET "to_param="
IF NOT "%tiempo_fin%"=="" SET to_param=-to %tiempo_fin%

:: Selección de codec y formato
IF /i "%codec%"=="y" SET codec=libx264
IF /i "%codec%"=="a" SET codec=libx264
IF "%codec%"=="" SET codec=hevc

IF "%format%"=="" SET format=mp4

:: Comando
ffmpeg -hide_banner -stats -ss %tiempo_inicio% %to_param% -i "%~1" -preset medium -c:v %codec% -c:a aac %params% "%~n1-1.%format%" -y

endlocal