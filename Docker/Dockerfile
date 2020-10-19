FROM ubuntu:20.04

RUN set -xe \
  &&  echo '#!/bin/sh' > /usr/sbin/policy-rc.d \
  &&  echo 'exit 101' >> /usr/sbin/policy-rc.d \
  &&  chmod +x /usr/sbin/policy-rc.d \
  &&  dpkg-divert --local --rename --add /sbin/initctl \
  &&  cp -a /usr/sbin/policy-rc.d /sbin/initctl \
  &&  sed -i 's/^exit.*/exit 0/' /sbin/initctl \
  &&  echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup \
  &&  echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean \
  &&  echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean \
  &&  echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean \
  &&  echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages \
  &&  echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes \
  &&  echo 'Apt::AutoRemove::SuggestsImportant "false";' > /etc/apt/apt.conf.d/docker-autoremove-suggests \
  &&  DEBIAN_FRONTEND=noninteractive apt-get update \
  &&  echo "===> Installing handy tools (not absolutely required)..." \
  &&  apt-get install -y git wget vim curl rsync unzip gnupg python3-pip sshpass openssh-client ansible
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
RUN mkdir -p /run/systemd \
  &&  echo 'docker' > /run/systemd/container

RUN echo "===> Installing helpers and configuring Ansible..." \
  &&  pip3 install --upgrade pip \
  &&  pip3 install --upgrade pywinrm paramiko fabric packet-python python-dateutil jmespath \
  &&  echo 'localhost' > /etc/ansible/hosts

COPY entrypoint.sh /entrypoint.sh
COPY ansible/ /ansible
CMD ["ansible-playbook" "--version"]
ENTRYPOINT ["/entrypoint.sh"]
