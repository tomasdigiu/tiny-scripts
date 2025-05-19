@echo off

setlocal
set /P ss=Tiempo de inicio:
set /P to=Tiempo de fin: 
set /P param=Parametros extra: 

IF "%ss%"=="" SET /A ss=0

IF "%to%"=="" GOTO TO

ffmpeg -stats -i "%~1" -preset medium -c:v hevc -ss %ss% -to %to% %param% "%~n1-1.mp4"  -y
GOTO END

:TO
ffmpeg -stats -i "%~1" -preset medium -c:v hevc %param% -ss %ss% "%~n1-1.mp4" -y


:END
endlocal