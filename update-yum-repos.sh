#!/bin/bash
# Create or update the epel.repo file
cat > /etc/yum.repos.d/epel.repo <<EOL
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

# Clean the Yum cache
yum clean all

# Update the system
yum update -y

echo "Yum update completed."
