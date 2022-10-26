# syntax=docker/dockerfile:1.3-labs
FROM debian:bullseye-slim as ssh-client

RUN <<EOF
apt update
apt install -y ssh ssh-tools

useradd -ms /bin/bash -u 1000 user
EOF

USER user
WORKDIR /home/user

FROM ssh-client as ssh-server

USER root

EXPOSE 22

HEALTHCHECK --interval=1s CMD ["/etc/init.d/ssh", "status"]

FROM ssh-client as ssh-ca