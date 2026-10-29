@ECHO OFF
SETLOCAL

set "cookies_path="%~dp0cookies.txt""

IF NOT EXIST %cookies_path% CALL :crear_cookies

IF EXIST %cookies_path% SET "cookies_param=--cookies %cookies_path%"

gallery-dl.exe -D .\gallery %cookies_param% %*

endlocal & goto:eof

:crear_cookies
setlocal
	echo:
	echo Las cookies son necesarias para descargar, por ejemplo, videos protegidos.
	echo No existe cookies.txt en el directorio del script. Crear?
	set /P "crear=El navegador debe estar cerrado para proceder. s/n: "
	if /I "%crear%"=="y" set "crear=s"
	if /I not "%crear%"=="s" goto:eof

	echo:
	echo IMPORTANTE: no compartir cookies.txt. Contiene informacion de todas tus sesiones.
	echo Navegadores soportados: brave, chrome, chromium, edge, firefox, opera, safari, vivaldi, whale
	set /p browser=Escribe tu navegador: 
	yt-dlp.exe --cookies-from-browser %browser% --cookies %cookies_path% 2>nul
endlocal & goto:eof