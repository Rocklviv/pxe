default['pxe']['hostname'] = '192.168.56.5'

# HTTP image dir
default['http-chef-pxe']['image_name'] = 'centos'
default['http-chef-pxe']['http_dir'] = '/var/www/html/'
default['http-chef-pxe']['image_dir'] = "#{node['http-chef-pxe']['http_dir']}#{node['http-chef-pxe']['image_name']}"
default['http-chef-pxe']['image_ks_dir'] = '/var/www/html/ks'
default['http-chef-pxe']['ks_filename'] = 'Centos6-5.minimal.ks'
default['http-chef-pxe']['port'] = 90
default['apache']['listen_ports'] = [node['http-chef-pxe']['port']]

# ISO Configuration
default['iso']['name'] = 'CentOS-6.5-x86_64-minimal.iso'
default['iso']['tmp_dir'] = "/tmp/#{node['iso']['name']}"
default['iso']['mount_dir'] = "/tmp/mnt"

# TFTP directory for netboot
default['tftp']['centos_dir'] = '/var/lib/tftpboot/centos'
default['tftp']['centos_arch_dir'] = "#{node['tftp']['centos_dir']}/x86_64"
default['image']['url'] = 'http://ftp.tlk-l.net/pub/mirrors/centos.org/6.5/isos/x86_64/CentOS-6.5-x86_64-minimal.iso' #http://ftp.tlk-l.net/pub/mirrors/centos.org/6.5/isos/x86_64/CentOS-6.5-x86_64-minimal.iso
default['download']['from_web'] = true