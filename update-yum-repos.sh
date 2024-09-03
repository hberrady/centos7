#!/bin/bash

# Backup the existing epel.repo if it exists
if [ -f /etc/yum.repos.d/epel.repo ]; then
    cp /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.bak
    echo "Backup of the existing epel.repo created: /etc/yum.repos.d/epel.repo.bak"
fi

# Create or update the epel.repo file using tee
sudo tee /etc/yum.repos.d/epel.repo > /dev/null <<EOL
[epel]
name=Extra Packages for Enterprise Linux 7 - \$basearch
baseurl=https://download.fedoraproject.org/pub/epel/7/\$basearch/
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7

[epel-debuginfo]
name=Extra Packages for Enterprise Linux 7 - \$basearch - Debug
baseurl=https://download.fedoraproject.org/pub/epel/7/\$basearch/debug/
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-debug-7&arch=\$basearch
enabled=0
gpgcheck=1
gpgkey=https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7

[epel-source]
name=Extra Packages for Enterprise Linux 7 - \$basearch - Source
baseurl=https://download.fedoraproject.org/pub/epel/7/SRPMS/
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-source-7&arch=\$basearch
enabled=0
gpgcheck=1
gpgkey=https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
EOL

echo "epel.repo file updated."

# Create or update the CentOS-Base.repo file using tee
sudo tee /etc/yum.repos.d/CentOS-Base.repo > /dev/null <<EOF
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

echo "CentOS-Base.repo file updated."

# Clean the Yum cache
yum clean all

# Update the system
yum update -y

echo "Yum update completed."

# Install the EPEL repository (a prerequisite for the Remi repository)
yum install -y epel-release  # 1. Install the EPEL repository

# Install the Remi repository package
yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm  # 2. Download and install the Remi repository

# Verify the installation of the Remi repository
yum list installed remi-release  # 3. Check if the remi-release package is installed

# Enable the Remi repository for PHP 7.1
yum-config-manager --enable remi-php71  # 4. Enable the Remi repository for PHP 7.1

# Install PHP 7.1 from the Remi repository
yum install -y php  # 5. Install PHP 7.1

