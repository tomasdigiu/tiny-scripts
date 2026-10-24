:: If needed, create cookies.txt at \resources\

@ECHO OFF
SETLOCAL

SET "cookies_param="
IF EXIST "%~dp0resources\cookies.txt" SET "cookies_param=--cookies \"%~dp0resources\cookies.txt\""

gallery-dl -D .\gallery %cookies_param% %*

ENDLOCAL