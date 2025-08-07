@echo off
echo Svuotamento del Cestino in corso...
rd /s /q %systemdrive%\$Recycle.bin
echo Cestino svuotato con successo!
pause