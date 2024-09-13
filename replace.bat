@echo off
setlocal

set "FONT_URL=https://github.com/lopezcc/rbx-font/raw/main/minecraft_font.ttf"
set "TEMP_FONT_FILE=%TEMP%\minecraft_font.ttf"
set "USER_PROFILE=%USERPROFILE%"
set "ROBLOX_DIR=%USER_PROFILE%\AppData\Local\Roblox\Versions"
set "BACKUP_FILE_SUFFIX=.bak"

echo Downloading font file...
powershell -Command "Invoke-WebRequest -Uri %FONT_URL% -OutFile %TEMP_FONT_FILE%"

for /f "delims=" %%i in ('dir /b /o-d "%ROBLOX_DIR%\version-*"') do (
    set "LATEST_VERSION_DIR=%ROBLOX_DIR%\%%i"
    goto :found_version
)
:found_version

if not exist "%LATEST_VERSION_DIR%" (
    echo No Roblox version directory found.
    pause
    exit /b 1
)

set "FONT_DIR=%LATEST_VERSION_DIR%\content\fonts"
set "FONT_FILE=%FONT_DIR%\PressStart2P-Regular.ttf"
set "BACKUP_FILE=%FONT_FILE%%BACKUP_FILE_SUFFIX%"

if exist "%FONT_FILE%" (
    echo Backing up original font...
    copy /y "%FONT_FILE%" "%BACKUP_FILE%"
) else (
    echo PressStart2P-Regular.ttf not found.
)

echo Replacing font...
copy /y "%TEMP_FONT_FILE%" "%FONT_FILE%"

echo Cleaning up...
del /q "%TEMP_FONT_FILE%"

echo Successfully replaced font.

pause

endlocal
