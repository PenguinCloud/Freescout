FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG APP_TITLE="Freescout"
ARG APP_LINK="https://freescout.net/download/"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DATABASE_NAME="freescout"
ENV DATABASE_USER="freescout"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="mariadb"
ENV DATABASE_PORT="3306"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV ORGANISATION_HOSTNAME="ptg.org"
ENV SERVER_ADDRESS="localhost"
ENV SSL_CERT="open"
ENV PROTOCOL="https"
ENV HTTP_PORT="8080"
ENV HTTPS_PORT="8443"
ENV URL="https://localhost:8443"
ENV FILE_LIMIT="1042"
ENV ADMIN_NAME="John"
ENV ADMIN_LASTNAME="Doe"
ENV ADMIN_EMAIL="johndoe@example.com"
ENV ADMIN_PASSWORD="pass"

# Switch to non-root user
USER ptg-user

EXPOSE 8080 8443

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]