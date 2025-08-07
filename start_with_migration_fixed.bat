@echo off
echo Starting Django server with MailChimp migration...
echo.

REM Change to the project directory
cd /d %~dp0

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

REM Make sure database migrations are up to date
echo Checking for any pending database migrations...
python manage.py migrate
if %ERRORLEVEL% NEQ 0 (
  echo Error: Database migration failed!
  pause
  exit /b 1
)
echo Database migrations are up to date.
echo.

REM Run the MailChimp migration script
echo Running MailChimp data migration...
python manage.py shell -c "exec(open('members/mailchimp_migration.py').read()); migrate_to_mailchimp_contacts()"
if %ERRORLEVEL% NEQ 0 (
  echo Error: MailChimp migration failed!
  pause
  exit /b 1
)
echo MailChimp migration completed successfully.
echo.

REM Start the Django server
echo Starting Django development server...
echo.
echo Access the admin interface at: http://127.0.0.1:8000/admin/
echo.
echo IMPORTANT: To stop the server, press CTRL+C in this window or run stop_django_server.bat
echo.
python manage.py runserver

pause
