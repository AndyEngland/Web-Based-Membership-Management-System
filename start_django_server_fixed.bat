@echo off
echo Starting Django server...

REM Change to the project directory
cd /d "c:\Work\active_projects\Yzer_Conservancy"

REM Activate virtual environment
echo Activating virtual environment...
call .venv\Scripts\activate.bat
if %ERRORLEVEL% NEQ 0 (
  echo Error: Could not activate virtual environment!
  echo Please make sure the virtual environment exists at .venv\Scripts\activate.bat
  pause
  exit /b 1
)
echo Virtual environment activated.
echo.

REM Check if Django is installed
python -c "import django; print(f'Django {django.__version__} is installed')"
if %ERRORLEVEL% NEQ 0 (
  echo Error: Django is not installed in the virtual environment!
  echo Please run: pip install -r requirements.txt
  pause
  exit /b 1
)
echo.

echo If you see any errors, please run these commands first:
echo python manage.py makemigrations
echo python manage.py migrate
echo.

REM Start the Django server
echo Starting Django development server...
echo.
echo Access the admin interface at: http://127.0.0.1:8000/admin/
echo.
echo IMPORTANT: To stop the server, press CTRL+C in this window or run stop_django_server.bat
echo.
python manage.py runserver

if errorlevel 1 (
    echo There was an error starting the server.
    echo Please check the error message above.
)
pause
