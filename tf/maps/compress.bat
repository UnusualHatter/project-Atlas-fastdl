@echo off
setlocal

:: ============================================================================
::                Bulk BZ2 Compressor for TF2 FastDL
:: ============================================================================
::
::  Purpose:  Compresses every file in the current directory into its own
::            .bz2 archive. For example, "map.bsp" becomes "map.bsp.bz2".
::
::  Requires: 7-Zip needs to be installed on this computer.
::
::  SETUP:    You MUST update the SEVENZIP_PATH variable below to point to
::            where 7z.exe is located on your system.
::
:: ============================================================================

:: --- CONFIGURATION ---
:: Set the full path to your 7-Zip executable (7z.exe)
:: Common paths are shown below. Uncomment the correct one or write your own.
SET "SEVENZIP_PATH=C:\Program Files\7-Zip\7z.exe"
:: SET "SEVENZIP_PATH=C:\Program Files (x86)\7-Zip\7z.exe"


:: --- SCRIPT BODY ---
TITLE Compressing Files to BZ2...

:: Check if the 7-Zip path is valid
if not exist "%SEVENZIP_PATH%" (
    echo.
    echo ERROR: 7-Zip executable not found at the specified path.
    echo Please edit this script and correct the SEVENZIP_PATH variable.
    echo.
    echo Path currently set to: "%SEVENZIP_PATH%"
    echo.
    goto :end
)

echo.
echo Starting BZ2 compression process...
echo 7-Zip location: "%SEVENZIP_PATH%"
echo.

:: Loop through all files (*.*) in the current directory
FOR %%f IN (*.*) DO (
    :: Check if the file is not this script itself
    if /I NOT "%%~nxf"=="%~nx0" (
        :: Check if a .bz2 compressed version does NOT already exist
        if NOT EXIST "%%f.bz2" (
            echo Compressing "%%f"...
            "%SEVENZIP_PATH%" a -tbzip2 "%%f.bz2" "%%f" > nul
        ) ELSE (
            echo Skipping "%%f" (Already compressed)
        )
    )
)

echo.
echo ========================
echo  Compression complete.
echo ========================
echo.

:end
pause