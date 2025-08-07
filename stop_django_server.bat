@echo off
echo Looking for Django server processes...
tasklist /FI "IMAGENAME eq python.exe" /FO TABLE
echo.
echo The above are running Python processes.
echo If you see a python.exe process running, you can stop it using the option below.
echo.
set /p confirm="Do you want to stop all Python processes? (y/n): "
if /i "%confirm%" neq "y" goto :end
echo.
echo Stopping all Python processes...
taskkill /F /IM python.exe
echo.
echo If no error message appeared, all Python processes have been stopped.
echo The Django server has been shut down.
goto :end

:end
echo.
pause
