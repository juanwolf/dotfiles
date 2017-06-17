FROM ubuntu:latest
RUN useradd -ms /bin/bash ubuntu
USER ubuntu
ADD . /home/ubuntu/dotfiles
WORKDIR /home/ubuntu/dotfiles
RUN "./install.sh"
