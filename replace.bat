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
set "COMIC_NEUE_FILE=%FONT_DIR%\ComicNeue-Angular-Bold.ttf"
set "BACKUP_FILE=%COMIC_NEUE_FILE%%BACKUP_FILE_SUFFIX%"

if exist "%COMIC_NEUE_FILE%" (
    echo Backing up original font...
    copy /y "%COMIC_NEUE_FILE%" "%BACKUP_FILE%"
) else (
    echo ComicNeue-Angular-Bold.ttf not found.
)

echo Replacing font...
copy /y "%TEMP_FONT_FILE%" "%COMIC_NEUE_FILE%"

echo Cleaning up...
del /q "%TEMP_FONT_FILE%"

echo Successfully replaced font.

pause

endlocal