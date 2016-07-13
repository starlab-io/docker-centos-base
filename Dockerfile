FROM centos:7.2.1511
MAINTAINER Star Lab <info@starlab.io>

RUN mkdir /source

# Add the proxy cert
RUN update-ca-trust force-enable
ADD proxy.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust extract

# build dependencies
RUN yum install -y git kernel-devel wget bc openssl-devel python-setuptools \
        python-virtualenv dracut-network nfs-utils check && \
    yum groupinstall -y "Development Tools" && \
    yum clean all && \
    rm -rf /var/cache/yum/* /tmp/* /var/tmp/*

VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
