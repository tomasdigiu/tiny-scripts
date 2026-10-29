# tiny scripts
Scripts que fui haciendo con el tiempo y en base a mis necesidades. La idea es tener herramientas rápidas para convertir o descargar imágenes y videos sin necesidad de abrir un programa entero.

## conv.bat y gif.bat
**Modo de uso**: arrastrando un video al script, o pasándolo como parámetro por consola. Ejemplo: 
```
C:\>conv input.mp4
C:\>gif input.mp4
```

### conv.bat
Para convertir y recortar videos con ffmpeg. Por default (sin poner valores en los prompts que te pide) te convierte el video a `.mp4` con codec `hevc`.

Si se selecciona **copy** como codec, se crea un archivo sin recodificación, por lo que recortar un video es prácticamente instantáneo. Según el formato del input, esto puede generar inconsistencias en la reproducción.

### gif.bat
Para crear gifs de alta calidad usando ffmpeg y gifski.

Recomiendo ejecutar `gifski.exe -h` en la consola para ver las (pocas) opciones disponibles, pero una que destaco es:

`-Q, --quality <1-100>` Por default es 90, y bajarlo un poco ayuda bastante a reducir el tamaño del output sin afectar tanto la calidad, aunque la mayor diferencia la hace el tamaño y los FPS.


## yt.bat y gallery.bat
**Modo de uso**: por consola, pasando opciones si se desea, seguido de uno o más links.
```
C:\>yt [opciones] <URL> [<URL>...]
C:\>gallery [opciones] <URL> [<URL>...]
```

### Páginas protegidas, contenido sensible, cuentas privadas, etc
En algunos casos, la página requiere una verificación para acceder al contenido que se quiere descargar, ya sea a través de captchas o requiriendo un inicio de sesión.

Para esto se utilizan las **cookies**, que contienen las sesiones abiertas e información de tu navegador y permiten acceder a estos contenidos. Estas cookies se pasan a yt-dlp o gallery-dl por un archivo `cookies.txt`, el cual puede ser creado con los scripts si este no se encuentra en el directorio.

> **IMPORTANTE: este archivo cookies.txt no debe ser compartido ya que contiene todas tus sesiones abiertas, y puede ser usado para acceder fácilmente a ellas**. 

> Después veo si puedo quitar esta opción, porque es bastante inseguro.


### yt.bat
Para descargar videos. Soporta un gran número de páginas, listadas en el [repo oficial de yt-dlp](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md).

Ejecutar `yt --help` para ver las opciones disponibles. Destaco una sola:

`-t <template>` Templates para descargar un formato específico. `<template>` puede ser **mp4**, **mp3**, **mkv** o **aac**.

### gallery.bat
Para descargar de sitios de hosteo de imágenes, listados en el [repo oficial de gallery-dl](https://github.com/mikf/gallery-dl/blob/master/docs/supportedsites.md).

Ejecutar `gallery --help` para ver las opciones disponibles. Destaco las siguientes:

`--range <RANGE>` Cantidad o rango de imágenes a descargar. Ej: `5`, `2-8`.

`--filter "extension in ('png', 'jpg')"` Para filtrar  según su extensión los archivos que se van a descargar. También se puede excluir extensiones: `--filter "extension not in ('mp4', 'gif')"`
