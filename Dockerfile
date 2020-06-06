FROM centos:7

MAINTAINER tinamou

ENV container=docker

ENV pip_packages "ansible"

RUN yum makecache fast \
  && yum -y install deltarpm epel-release initscripts \
  && yum -y update \
  && yum -y install \
      sudo \
      which \
      python3-pip \
      vim \
  && yum clean all

# Install systemd -- See https://hub.docker.com/_/centos/
RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

ENV pip_packages "ansible"

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]

