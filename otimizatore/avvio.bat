@echo off
:: ================================================
:: AVVIA ADMIN - Esecuzione differenziata CMD
:: Supporta Windows 7/8/10/11
:: ================================================

title Gestore Esecuzione Script
color 9f
setlocal enabledelayedexpansion

:: 1. Verifica preliminare
if not exist "non.cmd" (
    echo ERRORE: [non.cmd] non trovato in:
    echo %cd%
    pause
    exit /b 1
)

if not exist "fine.cmd" (
    echo ERRORE: [fine.cmd] non trovato in:
    echo %cd%
    pause
    exit /b 1
)

:: 2. Esecuzione non.cmd (modalità normale)
echo.
echo [FASE 1] Esecuzione non.cmd...
call "non.cmd"
set "non_exitcode=!errorlevel!"
echo Exit Code: !non_exitcode!

:: 3. Esecuzione fine.cmd (come admin)
echo.
echo [FASE 2] Avvio fine.cmd come amministratore...
echo * Verrà richiesta l'autorizzazione UAC *

:: Metodo compatibile con tutti i Windows
set "current_path=%cd%"
set "vbs_script=%temp%\elevate.vbs"

:: Crea script VBS temporaneo
(
echo Set UAC = CreateObject^("Shell.Application"^)
echo UAC.ShellExecute "cmd.exe", "/c ""cd /d """"%current_path%"""" && call fine.cmd""", "", "runas", 1
)>"%vbs_script%"

start "" /wait "%vbs_script%"
del "%vbs_script%" >nul 2>&1

:: 4. Risultati finali
echo.
echo **************************************
echo * RIEPILOGO ESECUZIONE
echo **************************************
echo - non.cmd completato (Code: !non_exitcode!)
echo - fine.cmd avviato come admin
echo.
echo Operazione completata!
timeout /t 10 /nobreak >nul
exit /b 0