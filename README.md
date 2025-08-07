# Web-Based Membership Management System

A Django-based web application for managing organizational memberships.

## Features

- Member registration and management
- Organization management
- User authentication and authorization
- Admin interface for data management

## Setup and Installation

### Prerequisites

- Python 3.10 or higher
- pip (Python package installer)
- Git

### Installation Steps

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd web-based-membership-management-system
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv .venv
   .venv\Scripts\activate  # On Windows
   # or
   source .venv/bin/activate  # On macOS/Linux
   ```

3. Install required packages:
   ```bash
   pip install -r requirements.txt
   ```

4. Run database migrations:
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

5. Create a superuser (optional):
   ```bash
   python manage.py createsuperuser
   ```

6. Start the development server:
   ```bash
   python manage.py runserver
   ```

7. Open your web browser and navigate to `http://127.0.0.1:8000/`

## Project Structure

- `yzer_membership/` - Main Django project directory
- `members/` - Django app for member management
- `manage.py` - Django management script
- `requirements.txt` - Python package dependencies
- `db.sqlite3` - SQLite database file

## Development

### Running the Server

You can use the provided batch files for convenience:
- `start_django_server.bat` - Start the Django development server
- `start_with_migration.bat` - Run migrations and start server
- `stop_django_server.bat` - Stop the Django server

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

[Add your license information here]
