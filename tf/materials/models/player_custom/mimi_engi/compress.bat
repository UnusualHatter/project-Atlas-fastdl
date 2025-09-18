@ECHO OFF
TITLE Compressor BZ2 com 7-Zip

:: Localiza o executável do 7-Zip. Altere esta linha se o seu estiver instalado em outro lugar.
SET "SEVEN_ZIP_PATH=%ProgramFiles%\7-Zip\7z.exe"

:: Verifica se o 7-Zip foi encontrado no caminho padrão.
IF NOT EXIST "%SEVEN_ZIP_PATH%" (
    ECHO.
    ECHO ERRO: 7-Zip nao encontrado em "%SEVEN_ZIP_PATH%".
    ECHO.
    ECHO Por favor, verifique se o 7-Zip esta instalado ou ajuste o caminho na primeira linha do script.
    ECHO.
    PAUSE
    EXIT /B
)

ECHO Iniciando compressao para .bz2...
ECHO ==========================================================

:: Este loop passa por todos os arquivos (*.*) no diretório atual.
FOR %%F IN (*.*) DO (
    :: Esta linha garante que o script não tente comprimir a si mesmo.
    IF /I NOT "%%~nxF"=="%~nx0" (
        ECHO Comprimindo "%%F"...
        
        :: Comando do 7-Zip para criar um arquivo .bz2
        :: a: Adicionar a um arquivo
        :: -tbzip2: Especifica o tipo de compressão como BZip2
        :: "%%F.bz2": Define o nome do arquivo de saída
        :: "%%F": Define o arquivo de entrada a ser comprimido
        :: > NUL: Oculta a saída detalhada do 7-Zip para uma visualização mais limpa.
        "%SEVEN_ZIP_PATH%" a -tbzip2 "%%F.bz2" "%%F" > NUL
    )
)

ECHO ==========================================================
ECHO Concluido! Pressione qualquer tecla para sair.
PAUSE > NUL