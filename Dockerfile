FROM debian:slim

RUN apt-get update && apt-get install -y \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

COPY setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

COPY levels/ /levels/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
