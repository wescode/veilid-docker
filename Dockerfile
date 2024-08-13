FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt dist-upgrade -y

RUN apt install software-properties-common gpg wget -y

RUN cd /tmp

RUN wget -O- https://packages.veilid.net/gpg/veilid-packages-key.public | gpg --dearmor -o /usr/share/keyrings/veilid-packages-keyring.gpg

RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/veilid-packages-keyring.gpg] https://packages.veilid.net/apt stable main" > /etc/apt/sources.list.d/veilid.list

RUN apt-get update

RUN apt install veilid-server veilid-cli

RUN apt-get clean

COPY veilid-server.conf /etc/veilid-server/veilid-server.conf

EXPOSE 5150/tcp
EXPOSE 5150/udp

CMD ["/usr/bin/veilid-server","--foreground"]

