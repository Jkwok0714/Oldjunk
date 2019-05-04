@echo off
:Input
set /p In="Enter the source: "
set /p Out="Enter the destination: "
if not defined In echo "No input selected" & goto :Input
if not defined Out echo "No output selected" & goto :Input
echo %In%
echo %Out%
if not exist %Out% mkdir %Out%
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
robocopy /E %In% %Out% /xo /log:%Out%\Robolog_%mydate%.txt /tee /w:5 /r:2 /xa:SH /XD "$Windows.~BT" "Intel" "Program Files" "PerfLogs" "Windows"
pause
