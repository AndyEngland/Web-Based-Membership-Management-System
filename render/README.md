Render deployment notes

1) Connect your GitHub repo to Render and create a new Web Service.

2) Use the Docker option (Render will build the Dockerfile in repo root).

3) Environment variables to set in Render:
   - SECRET_KEY (a secure random string)
   - DEBUG=false
   - ALLOWED_HOSTS=admin.bewarea.org.za
   - DATABASE_URL (if you use managed Postgres)

4) Start command is handled by the container entrypoint (runs migrate + collectstatic and starts gunicorn).

5) After the service deploys, add a custom domain in Render: admin.bewarea.org.za. Render will give you a CNAME target.

6) In XNEELO DNS add a CNAME record:
   - Type: CNAME
   - Host/Name: admin
   - Value/Points to: <Render CNAME target provided by Render>

7) Wait for DNS to propagate; Render will provision TLS automatically.
