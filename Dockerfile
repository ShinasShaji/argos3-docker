# ARGOS INSTALL

FROM dorowu/ubuntu-desktop-lxde-vnc

WORKDIR /setup
COPY ./scripts /setup
ENV DEBIAN_FRONTEND=noninteractive

# SSH setup
RUN chmod +x /setup/ssh-setup.sh && bash /setup/ssh-setup.sh

# ARGOS setup
RUN chmod +x /setup/argos-setup.sh && bash /setup/argos-setup.sh
RUN chmod +x /setup/argos-examples.sh && bash /setup/argos-examples.sh

COPY ./scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "bash", "/usr/local/bin/entrypoint.sh" ]