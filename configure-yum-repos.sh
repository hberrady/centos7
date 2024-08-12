#!/bin/bash

# Copyright (C) 2024 HICHAM BERRADY
# This script is used to update and configure the yum repository files on CentOS 7
# and install PHP 7.1.33.

# Replace content of /etc/yum.repos.d/CentOS-Base.repo
sudo tee /etc/yum.repos.d/CentOS-Base.repo <<EOF
[base]
name=CentOS-\$releasever - Base
baseurl=http://vault.centos.org/7.9.2009/os/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-\$releasever - Updates
baseurl=http://vault.centos.org/7.9.2009/updates/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-\$releasever - Extras
baseurl=http://vault.centos.org/7.9.2009/extras/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-\$releasever - Plus
baseurl=http://vault.centos.org/7.9.2009/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF

# Replace content of /etc/yum.repos.d/epel.repo
sudo tee /etc/yum.repos.d/epel.repo <<EOF
[epel]
name=Extra Packages for Enterprise Linux 7 - \$basearch
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=\$basearch
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

[epel-debuginfo]
name=Extra Packages for Enterprise Linux 7 - \$basearch - Debug
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-debug-7&arch=\$basearch
failovermethod=priority
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

[epel-source]
name=Extra Packages for Enterprise Linux 7 - \$basearch - Source
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-source-7&arch=\$basearch
failovermethod=priority
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
EOF

# Clear yum cache
sudo yum clean all

# Install Remi repository
sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Enable the Remi repository for PHP 7.1
sudo yum-config-manager --enable remi-php71

# Refresh package list
sudo yum makecache

# Install PHP 7.1 and CLI
sudo yum install -y php php-cli

# Verify PHP installation
php -v

# To execute this script directly from GitHub:
# bash <(curl -s https://raw.githubusercontent.com/hberrady/centos7/main/configure-yum-repos.sh)
