<!--
Short, actionable instructions for AI coding agents working in this repo.
Focus on what a human developer needs the agent to know to be productive quickly.
-->
# Copilot instructions — Web-Based Membership Management System

These are concise, repository-specific rules and pointers for an AI coding agent. Follow them when making edits, running the app, or proposing changes.

- Project type: Django 4.2 web application (project root: `yzer_membership/`) with a single app `members`.
- DB: SQLite (file `db.sqlite3` in repo root). Settings in `yzer_membership/settings.py` use sqlite by default.
- Virtualenv: repository expects a `.venv/` at project root (README and batch scripts activate it). Prefer running commands inside the venv.

Important files and places to check before edits
- `manage.py` — primary entry for Django commands (migrations, runserver, createsuperuser).
- `yzer_membership/settings.py` — environment-sensitive values: `DEBUG=True` in repo, `SECRET_KEY` is a placeholder. Do not commit production secrets.
- `members/` — the application code. Look here for models, admin registration, Mailchimp integration (`mailchimp_implementation.py`, `mailchimp_migration.py`) and import utilities (`import_organizations.py`).
- `members/migrations/` — contains migration history. When modifying models, add migrations (`makemigrations`) and run `migrate`.
- `static`, `images/` and `STATICFILES_DIRS` — static files handling is configured; static root is `staticfiles`.
- `Dockerfile` and `entrypoint.sh` — container run path; keep Docker changes minimal and preserve existing entrypoint behaviour.

Run / dev workflows (explicit)
- Create venv and install: `python -m venv .venv` then activate and `pip install -r requirements.txt`.
- Migrations: `python manage.py makemigrations` then `python manage.py migrate`.
- Start server (preferred for local dev): `python manage.py runserver` (or use `start_django_server_fixed.bat` on Windows after updating the hard-coded path inside it).
- Create admin user: `python manage.py createsuperuser`.

Repository conventions and gotchas
- Windows helper scripts exist (e.g. `start_django_server.bat`, `start_with_migration.bat`, `stop_django_server.bat`). Some reference a different path (`Yzer_Conservancy`) — update the path before using or run Django commands directly.
- No test suite noticed — changes should be validated manually by running migrations and the dev server. There are several Jupyter notebooks in `notebooks/` used for payment processing (not unit tests).
- Mailchimp and import scripts live in `members/` as stand-alone modules (not necessarily wired to management commands). Search for explicit call sites before changing behaviour.
- Admin is used for data management; prefer adding admin registration alongside model changes in `members/admin.py`.

What to preserve when editing
- Keep `DATABASES` default to sqlite unless adding explicit support for other DB engines; migrations are present and must be kept in sync.
- Keep `STATICFILES_DIRS` entries (notably `images/`) unless intentionally migrating static assets.

Small contract for code changes (apply this checklist)
1. If you change models: add migrations (`makemigrations`) and include them in the diff.
2. Validate by running `python manage.py migrate` and then `python manage.py runserver`.
3. Update `members/admin.py` when model fields are added and ensure the admin UI still loads.
4. Do not commit secret keys or change `DEBUG` to False without documenting environment secrets and config.

Examples from codebase to reference
- DB config: `yzer_membership/settings.py` (uses `BASE_DIR / 'db.sqlite3'`).
- Static setup: `STATICFILES_DIRS = [ BASE_DIR / 'static', BASE_DIR / 'images' ]` in `settings.py`.
- Mailchimp helpers: `members/mailchimp_implementation.py` and `members/mailchimp_migration.py`.
- Import helper: `members/import_organizations.py`.

When you are uncertain
- Prefer minimal, easily-reversible edits and run the dev server to smoke-test. If changing data migrations, create new migrations rather than hand-editing old migration files.

If this file needs clarifying, tell me which edits or examples you'd like added (examples: common model shapes, a walkthrough for adding an API endpoint, or the Docker run sequence).
## Notes for Render (hosting)

- The project has been deployed to Render successfully in your environment. Keep these practical, repo-specific reminders for maintaining/tweaking the deployment:

- Environment variables: Set `SECRET_KEY` (do not commit it), `DEBUG=False` in production, and add your Render host to `ALLOWED_HOSTS`. Render provides `RENDER_EXTERNAL_HOSTNAME`; consider using that in `settings.py` or setting `ALLOWED_HOSTS` via an env var.

- Database: The repo uses SQLite by default (`db.sqlite3`). SQLite is not suitable for multi-instance production on Render — switch to a managed Postgres or other production DB and update `DATABASES` in `yzer_membership/settings.py`. Add DB credentials as environment variables (or use a `DATABASE_URL` parsing helper).

- Static files: The project uses Django staticfiles; in production run `python manage.py collectstatic --noinput` during the build step and serve `STATIC_ROOT` with Render static files configuration or via the Docker image. There is a `Dockerfile` and `entrypoint.sh` present — using Render's Docker deployment is the simplest path if you want to preserve the repository's existing startup behavior.

- Startup: Render can run a start command such as `gunicorn yzer_membership.wsgi:application --bind 0.0.0.0:$PORT` (ensure `gunicorn` is in `requirements.txt`) or use the provided `Dockerfile`/`entrypoint.sh` which already model a containerized start sequence.

- Migrations & maintenance: Add a build or deploy hook to run `python manage.py migrate` as part of the deploy or run it manually from the Render shell before switching traffic.

- Verify: After deploy, check the admin at `https://<your-service>.onrender.com/admin/` (create a superuser or set one up via manage.py). If static assets are missing, confirm `collectstatic` ran and that `STATIC_ROOT` is being served by Render or the container.
