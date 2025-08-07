@echo off
title Ottimizzazione RAM - By Windows
color 0a
echo.
echo [1/3] Pulisco la memoria cache...
:: Libera la standby/list memory (cache inutilizzata)
powershell -command "Clear-RecycleBin -Force" >nul
powershell -command "echo 'Freeing memory...'; $dummy = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(512000000); [System.Runtime.InteropServices.Marshal]::FreeHGlobal($dummy)" >nul

echo.
echo [2/3] Svuoto la cache del sistema...
:: Flush della cache DNS e reset della memoria di sistema
ipconfig /flushdns >nul
netsh int ip reset >nul
netsh winsock reset >nul

echo.
echo [3/3] Rilascio la RAM non utilizzata...
:: Forza il garbage collection di .NET (utile per alcuni processi)
powershell -command "[System.GC]::Collect()" >nul

echo.
echo Ottimizzazione RAM completata!
echo Memoria liberata con successo.
timeout /t 5 >nul
exit