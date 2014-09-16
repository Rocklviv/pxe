
# Example kickstart configuration file
#

install

# Specifies the language
lang en_US.UTF-8

# Specifies the keyboard layout
keyboard us

# Skip Red Hat subscriber key input
key --skip

# Forces the text installer to be used (saves time)
text

# Forces the cmdline installer to be used (debugging)
#cmdline

# Skips the display of any GUI during install (saves time)
skipx

# Used with an HTTP install to specify where the install files are located
url --url http://<%= @hostname%>:<%= @port%>/centos

# Assign a static IP address upon first boot & set the hostname
network --onboot yes --bootproto dhcp --hostname centos65

# Give the second interface a DHCP address (if you are not using a second interface comment this line out)
#network --device eth1 --bootproto=dhcp

# Set the root password
rootpw r00tp@55w0rd

# Enable the firewall and open port 22 for SSH remote administration
firewall --enabled --port=22:tcp

# Setup security and SELinux levels
#authconfig --enableshadow --enablemd5
authconfig --enableshadow --passalgo=sha512

selinux --disabled

# Set the timezone
timezone --utc Etc/UTC

# Create the bootloader in the MBR with drive sda being the drive to install it on
bootloader --location=mbr --driveorder=sda,sdb --append=audit=1

# Wipe all partitions and build them with the info below
clearpart --all --initlabel

#Disk partitioning information
zerombr

# Create primary partitions
part /boot --fstype ext4 --size=500 --asprimary --ondisk=sda
part swap --size=4096 --asprimary --ondisk=sda
part pv.01 --size=100 --grow --asprimary --ondisk=sda
# use the entire second disk for swap
#part swap --size=100 --grow --ondisk=sdb

# Create LVM logical volumes
volgroup system --pesize=32768 pv.01
logvol  /var  --vgname=system  --size=8196  --name=var_vol
logvol  /tmp  --vgname=system  --size=2048  --name=tmp_vol
logvol  /  --vgname=system  --size=100  --grow  --name=root_vol

# reboot when installation completes
reboot

# Install the Core software packages, aka "minimal", plus a couple extras
%packages
# minimal
@core
@server-policy
#@base
#@network-file-system-client
#@server-policy
%end

%pre
# redirect debugging output to tty3
#exec < /dev/tty3 > /dev/tty3
#chvt 3

%post --log=/var/tmp/install.log
# redirect debugging output to tty3
#exec < /dev/tty3 > /dev/tty3
#chvt 3
