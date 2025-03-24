@echo off
setlocal enabledelayedexpansion

:: Diretório atual onde o script será executado (diretório onde os arquivos .evtx estão)
set "DIR=%CD%"

:: Contadores
set "arquivos_com_espaco=0"
set "arquivos_convertidos=0"
set "arquivos_nao_convertidos=0"
set "arquivos_nao_ajustados=0"

:: Encontrando todos os arquivos .evtx no diretório atual
echo Encontrado os seguintes arquivos .evtx:
for %%F in (%DIR%\*.evtx) do (
    set "arquivo=%%~nxF"
    echo !arquivo!

    :: Verificando se o nome do arquivo contém espaço
    echo !arquivo! | findstr /c:" " >nul
    if not errorlevel 1 (
        set "arquivo_ajustado=!arquivo: =-!"
        set /a "arquivos_com_espaco+=1"
        echo Ajustando nome de !arquivo! para !arquivo_ajustado!
        
        ren "%%F" "!arquivo_ajustado!"
        if errorlevel 1 (
            echo Não foi possível ajustar o nome de "%%F"
            set /a "arquivos_nao_ajustados+=1"
        )
    )
)

echo.
echo Total de arquivos encontrados: !arquivos_com_espaco!
echo Total de arquivos com espaço no nome ajustados: !arquivos_com_espaco!
echo Total de arquivos não ajustados: !arquivos_nao_ajustados!
echo.

:: Iniciando o processo de conversão
echo Iniciando o processo de conversão...
for %%F in (%DIR%\*.evtx) do (
    set "arquivo=%%~nxF"
    set "nome_arquivo_json=!arquivo:.evtx=.json!"
    
    echo Convertendo %%F para !nome_arquivo_json!
    evtx_dump-v0.9.0.exe -o json -f "!nome_arquivo_json!" "%%F"
    if errorlevel 1 (
        echo Erro ao converter %%F
        set /a "arquivos_nao_convertidos+=1"
    ) else (
        set /a "arquivos_convertidos+=1"
    )
)

echo.
echo Processo de conversão concluído.
echo Total de arquivos convertidos: !arquivos_convertidos!
echo Total de arquivos não convertidos: !arquivos_nao_convertidos!
echo.

pause
