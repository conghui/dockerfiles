FROM conghui/su

MAINTAINER Conghui He <heconghui@gmail.com>

RUN yum update -y && yum install -y \
      make \
      automake \
      autoconf \
      libtool \
      git \
      libXt-devel \
      libX11-devel \
      libXaw-devel \
      gcc \
      gcc-gfortran \
      flex && \
      yum clean all

RUN mkdir -p /opt/SEP
RUN git clone http://zapad.Stanford.EDU/bob/SEPlib.git /opt/SEP/src && \
      cd /opt/SEP/src && autoreconf -vif && \
      cd /opt/SEP/src && ./configure --prefix=/opt/SEP  --with-su=/opt/SU && \
      cd /opt/SEP/src && make && make install && make clean && \
      cd / && rm -rf /opt/SEP/src && \
      echo "datapath=stdout" > ~/.datapath

ENV PATH /opt/SEP/bin:$PATH
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
