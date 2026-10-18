@echo off
setlocal EnableDelayedExpansion
title Publicar no GitHub
cd /d "%~dp0"

set "REPO=assembly-mips64"
set "AUTO=0"
if /i "%~1"=="auto" set "AUTO=1"

where git >nul 2>nul
if errorlevel 1 (
    echo [ERRO] Git nao encontrado. Instala em https://git-scm.com/download/win
    goto :fim
)

rem --- garantir repositorio local ---
if not exist ".git" git init -b main >nul
git branch -M main >nul 2>nul

git config --global user.name >nul 2>nul
if errorlevel 1 (
    if "%AUTO%"=="1" goto :semconfig
    set /p GNAME="O teu nome para os commits: "
    set /p GMAIL="O teu email do GitHub: "
    git config --global user.name "!GNAME!"
    git config --global user.email "!GMAIL!"
)

rem --- garantir ligacao ao GitHub (origin) ---
git remote get-url origin >nul 2>nul
if errorlevel 1 (
    if "%AUTO%"=="1" goto :semconfig
    echo.
    echo Ainda nao esta ligado ao GitHub.
    echo O repo %REPO% tem de existir em github.com ^(se nao existir, cria em https://github.com/new^)
    set "GHUSER="
    set /p GHUSER="O teu username do GitHub: "
    if "!GHUSER!"=="" goto :fim
    git remote add origin https://github.com/!GHUSER!/%REPO%.git
    echo Ligado a https://github.com/!GHUSER!/%REPO%
)

rem --- commit (se houver alteracoes) ---
git add -A
git diff --cached --quiet
if errorlevel 1 (
    git status --short
    set "MSG="
    if "%AUTO%"=="0" (
        echo.
        set /p MSG="Mensagem do commit (Enter = data/hora): "
    )
    if "!MSG!"=="" set "MSG=Atualizacao %date% %time:~0,5%"
    git commit -m "!MSG!"
)

rem --- push (tambem envia commits antigos que ficaram por enviar) ---
git push -u origin main
if errorlevel 1 (
    echo.
    echo Push recusado: a tentar juntar com o que ja esta no GitHub ^(ex: README criado no site^)...
    git pull origin main --allow-unrelated-histories --no-rebase --no-edit -X ours
    git push -u origin main
)
if errorlevel 1 (
    echo.
    echo [ERRO] O push falhou. Confirma que o repo existe e o username:
    git remote get-url origin
    echo Para corrigir o username: git remote set-url origin https://github.com/USERNAME/%REPO%.git
) else (
    echo.
    echo Enviado para o GitHub!
)
goto :fim

:semconfig
echo [%date% %time%] Falta configurar. Corre o publicar.bat a mao uma vez.

:fim
if "%AUTO%"=="0" pause
