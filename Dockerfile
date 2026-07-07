FROM ubuntu:latest

RUN apt-get update && apt-get install -y sudo git \
    && id -u ubuntu >/dev/null 2>&1 || useradd -ms /bin/bash ubuntu \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu
ADD --chown=ubuntu:ubuntu . /home/ubuntu/dotfiles
WORKDIR /home/ubuntu/dotfiles

# Run twice: the second run must be a no-op (idempotency smoke check).
RUN ./install.sh && ./install.sh
