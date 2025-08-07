@echo off
echo Activating virtual environment...
call C:\Work\active_projects\Yzer_Conservancy\venv\Scripts\activate

echo Collecting static files...
python manage.py collectstatic --noinput

echo Starting Django development server...
python manage.py runserver

pause
