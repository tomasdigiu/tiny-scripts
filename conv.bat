@echo off

setlocal
set /P ss=Tiempo de inicio:
set /P to=Tiempo de fin: 
set /P param=Parametros extra: 

IF "%ss%"=="" SET /A ss=0

IF "%to%"=="" GOTO TO

ffmpeg -hide_banner -stats -ss %ss% -to %to% -i "%~1" -preset medium -c:v hevc -c:a aac %param% "%~n1-1.mp4" -y
GOTO END

:TO
ffmpeg -hide_banner -stats -ss %ss% -i "%~1" -preset medium -c:v hevc -c:a aac %param% "%~n1-1.mp4" -y


:END
endlocal