FROM       ubuntu:14.04


RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:password' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir ~/go
ENV GOPATH ~/go
RUN wget --no-check-certificate https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz
RUN tar -xzf go1.7.4.linux-amd64.tar.gz -C /usr/local

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]