FROM centos:7

RUN yum update -y && yum install -y \
    make \
    libX11-devel \
    libXt-devel \
    gcc \
    tigervnc-server \
    xterm  \
    twm \
    git \
    xsetroot && \
    yum clean all

ENV CWPROOT /opt/SU
RUN mkdir $CWPROOT
RUN curl ftp://ftp.cwp.mines.edu/pub/cwpcodes/cwp_su_all_44R1.tgz | tar xz -C $CWPROOT && \
    sed 's/checkroot LICENSE_44_ACCEPTED MAILHOME_44//' -i $CWPROOT/src/Makefile && \
    cd $CWPROOT/src && make install xtinstall && rm -rf $CWPROOT/src

ENV PATH $CWPROOT/bin:$PATH
