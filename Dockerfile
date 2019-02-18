FROM centos:7.6.1810
MAINTAINER Star Lab <info@starlab.io>

RUN mkdir /source

# Add the proxy cert
RUN update-ca-trust force-enable
ADD proxy.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust extract

# build dependencies
RUN yum install -y git kernel-devel wget bc openssl openssl-devel python-setuptools \
        python-virtualenv dracut-network nfs-utils check && \
    yum groupinstall -y "Development Tools" && \
    yum clean all && \
    rm -rf /var/cache/yum/* /tmp/* /var/tmp/*

# Add python-pip
ADD pip-1.5.6.tar.gz /root/
RUN cd /root/pip-1.5.6 && python ./setup.py install

VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
