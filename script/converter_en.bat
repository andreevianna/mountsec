@echo off
setlocal enabledelayedexpansion

:: Current directory where the script will be executed (the directory where the .evtx files are located)
set "DIR=%CD%"

:: Counters
set "files_with_space=0"
set "files_converted=0"
set "files_not_converted=0"
set "files_not_renamed=0"

:: Finding all .evtx files in the current directory
echo Found the following .evtx files:
for %%F in (%DIR%\*.evtx) do (
    set "file=%%~nxF"
    echo !file!

    :: Checking if the file name contains spaces
    echo !file! | findstr /c:" " >nul
    if not errorlevel 1 (
        set "file_renamed=!file: =-!"
        set /a "files_with_space+=1"
        echo Renaming !file! to !file_renamed!
        
        ren "%%F" "!file_renamed!"
        if errorlevel 1 (
            echo Could not rename "%%F"
            set /a "files_not_renamed+=1"
        )
    )
)

echo.
echo Total files found: !files_with_space!
echo Total files with spaces in the name renamed: !files_with_space!
echo Total files that could not be renamed: !files_not_renamed!
echo.

:: Starting the conversion process
echo Starting conversion process...
for %%F in (%DIR%\*.evtx) do (
    set "file=%%~nxF"
    set "json_file_name=!file:.evtx=.json!"
    
    echo Converting %%F to !json_file_name!
    evtx_dump-v0.9.0.exe -o json -f "!json_file_name!" "%%F"
    if errorlevel 1 (
        echo Error converting %%F
        set /a "files_not_converted+=1"
    ) else (
        set /a "files_converted+=1"
    )
)

echo.
echo Conversion process completed.
echo Total files converted: !files_converted!
echo Total files not converted: !files_not_converted!
echo.

pause
