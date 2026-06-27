@echo off

setlocal
set /P ss=Tiempo de inicio:
set /P to=Tiempo de fin: 
set /P param=Parametros extra: 
set /P gay=Usar libx264? 
set /P format=Extension (default: mp4): 

IF "%gay%"=="y" SET gay=-c:v libx264

IF "%format%"=="" SET format=mp4

IF "%ss%"=="" SET ss=0

IF "%to%"=="" GOTO TO

ffmpeg -hide_banner -stats -ss %ss% -to %to% -i "%~1" -preset medium -c:v hevc -c:a aac %gay% %param% "%~n1-1.%format%" -y
GOTO END

:TO
ffmpeg -hide_banner -stats -ss %ss% -i "%~1" -preset medium -c:v hevc -c:a aac %gay% %param% "%~n1-1.%format%" -y


:END

endlocal