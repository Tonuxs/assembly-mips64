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

rem --- primeira vez: criar o repositorio (so no modo manual) ---
if not exist ".git" (
    if "%AUTO%"=="1" (
        echo [%date% %time%] Repositorio ainda nao configurado. Corre o publicar.bat a mao uma vez.
        goto :fim
    )
    echo Primeira execucao: a configurar o repositorio...
    git init -b main

    git config --global user.name >nul 2>nul
    if errorlevel 1 (
        set /p GNAME="O teu nome para os commits: "
        set /p GMAIL="O teu email do GitHub: "
        git config --global user.name "!GNAME!"
        git config --global user.email "!GMAIL!"
    )

    where gh >nul 2>nul
    if not errorlevel 1 (
        gh auth status >nul 2>nul || gh auth login
        git add -A
        git commit -m "Exercicios de Assembly MIPS64 (Sistemas 1)"
        gh repo create %REPO% --public --source . --remote origin --push
        echo.
        echo Feito! Repositorio criado e enviado.
        goto :fim
    )

    echo.
    echo Cria primeiro um repo VAZIO chamado %REPO% em https://github.com/new
    start https://github.com/new
    set /p GHUSER="O teu username do GitHub: "
    git remote add origin https://github.com/!GHUSER!/%REPO%.git
)

rem --- commit + push ---
git add -A
git diff --cached --quiet
if not errorlevel 1 (
    echo Nada de novo para enviar.
    goto :fim
)

git status --short
set "MSG="
if "%AUTO%"=="0" (
    echo.
    set /p MSG="Mensagem do commit (Enter = data/hora): "
)
if "!MSG!"=="" set "MSG=Atualizacao %date% %time:~0,5%"

git commit -m "!MSG!"
git push -u origin main
if errorlevel 1 (
    echo [ERRO] O push falhou. Verifica o login no GitHub e o nome do repo.
) else (
    echo Enviado para o GitHub!
)

:fim
if "%AUTO%"=="0" pause
