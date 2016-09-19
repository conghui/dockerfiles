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

ENV SEP=/opt/SEP
ENV SU=/opt/SU
RUN mkdir -p $SEP
RUN git clone http://zapad.Stanford.EDU/bob/SEPlib.git $SEP/src && \
      cd $SEP/src && autoreconf -vif && \
      cd $SEP/src && ./configure --prefix=$SEP  --with-su=$SU && \
      cd $SEP/src && make && make install && make clean && \
      cd / && rm -rf $SEP/src && \
      echo "datapath=stdout" > ~/.datapath

ENV PATH $SEP/bin:$PATH
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
