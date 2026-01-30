@echo off
@rem FastCmd %o1%

chcp 65001 > nul

for /F "tokens=1,2 delims=#" %%a in ('
    "prompt #$H#$E# & echo on & for %%b in (1) do rem"
') do set "ESC=%%b" 2>nul

:: Caminho do extractor
set "EXTRACTOR_PATH=%~dp0extractor.exe"

:: Verifica se foi iniciado sem arquivo
if "%~1"=="" (
    cls
    call :beep_error
    echo =====================================================
    echo %ESC%[91mERRO: Nenhum arquivo foi selecionado!%ESC%[0m
    echo =====================================================
    echo Arraste um arquivo .scs ou .zip para cima deste .exe
    echo para poder desbloquear o mod.
    echo.
    pause
    exit
)

:: Só toca a musiquinha se NÃO estiver no modo erro
call :beep_startup

:: Verifica status do extractor
if exist "%EXTRACTOR_PATH%" (
    set "EXTRACTOR_STATUS=On"
    set "EXTRACTOR_COLOR=%ESC%[92m"
) else (
    set "EXTRACTOR_STATUS=Off - extractor.exe não foi encontrado"
    set "EXTRACTOR_COLOR=%ESC%[91m"
)

:menu
cls

:: Atualiza status sempre que voltar pro menu
if exist "%EXTRACTOR_PATH%" (
    set "EXTRACTOR_STATUS=On"
    set "EXTRACTOR_COLOR=%ESC%[92m"
) else (
    set "EXTRACTOR_STATUS=Off - extractor.exe não foi encontrado"
    set "EXTRACTOR_COLOR=%ESC%[91m"
)

echo =====================================================
echo(
echo(  ███████╗██╗    ██╗███████╗███████╗████████╗██╗   ██╗  ███╗   ██╗██╗      ██████╗  ██████╗██╗  ██╗███████╗██████╗
echo(  ██╔════╝██║    ██║██╔════╝██╔════╝╚══██╔══╝██║   ██║  ████╗  ██║██║     ██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
echo(  ███████╗██║ █╗ ██║█████╗  █████╗     ██║   ██║   ██║  ██╔██╗ ██║██║     ██║   ██║██║     █████╔╝ █████╗  ██████╔╝
echo(  ╚════██║██║███╗██║██╔══╝  ██╔══╝     ██║   ██║   ██║  ██║╚██╗██║██║     ██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
echo(  ███████║╚███╔███╔╝███████╗███████╗   ██║   ╚██████╔╝  ██║ ╚████║███████╗╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
echo(  ╚══════╝ ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝    ╚═════╝   ╚═╝  ╚═══╝╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
echo(
echo =====================================================
echo ➤ Mantenha o extractor.exe atualizado:
echo %ESC%[94mhttps://github.com/sk-zk/Extractor/releases%ESC%[0m
echo ➤ Ultima atualização do extractor.exe: 11/12/2025
echo =====================================================
echo ➤ Bem-vindo(a): %USERNAME%
echo ➤ Data: %DATE%
echo ➤ Pasta Padrão: %ESC%[92mSweetRlk%ESC%[0m
echo ➤ Versão: 0.3
echo ➤ Status Extractor: %EXTRACTOR_COLOR%%EXTRACTOR_STATUS%%ESC%[0m
echo =====================================================
echo ➤ Mod Selecionado: %ESC%[93m%~nx1%ESC%[0m
echo [1] %ESC%[92mDesbloquear Mod%ESC%[0m
echo [2] %ESC%[91mSair%ESC%[0m
echo =====================================================
set /p opt="Escolha uma opção: "
call :beep_confirm

if "%opt%"=="1" goto extracao
if "%opt%"=="2" (
    call :beep_exit
    exit
)

goto menu

:extracao
cls

:: Bloqueia se extractor não existir
if not exist "%EXTRACTOR_PATH%" (
    call :beep_error
    echo.
    echo %ESC%[91mERRO: extractor.exe não foi encontrado no diretório!%ESC%[0m
    echo Coloque o extractor.exe na mesma pasta deste programa.
    echo.
    pause
    goto menu
)

echo.
echo %ESC%[91mDesbloqueando...%ESC%[0m
"%EXTRACTOR_PATH%" "%~1" --deep --dest SweetRlk

call :beep_success
echo.
echo Finalizado! Confira a pasta: %ESC%[92mSweetRlk%ESC%[0m

:final
echo.
echo =====================================================
echo [1] %ESC%[92mAbrir pasta SweetRlk%ESC%[0m
echo [2] %ESC%[93mVoltar para o menu%ESC%[0m
echo =====================================================
set /p endopt="Escolha uma opção: "
call :beep_confirm

if "%endopt%"=="1" (
    start "" "%~dp0SweetRlk"
    call :beep_success
    goto final
)

if "%endopt%"=="2" goto menu

goto final


:: ==============================
:: FUNÇÕES DE SOM
:: ==============================
:beep_confirm
powershell -c "[console]::beep(900,120)"
exit /b

:beep_success
powershell -c "[console]::beep(1500,200)"
exit /b

:beep_error
powershell -c "[console]::beep(400,200); [console]::beep(400,200)"
exit /b

:beep_exit
powershell -c "[console]::beep(800,120); [console]::beep(600,180)"
exit /b

:beep_startup
powershell -c "[console]::beep(1200,120); [console]::beep(1500,120); [console]::beep(1800,200)"
exit /b
