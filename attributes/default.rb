if platform_family?('debian')
	default['packages'] = %w(dhcp3-server syslinux)
elsif platform_family?('rhel')
	default['packages'] = %w(dhcp syslinux)
end

if platform?('ubuntu') && node['platform_version'] >= '14.04'
  set['apache']['version'] = '2.4'
end

# TTFP configuration.
default['tftpd']['config'] = '/etc/default/tftpd-hpa'
default['tftpd']['pxe_cfg'] = '/var/lib/tftpboot/pxelinux.cfg'
default['tftpd']['pxelinux'] = '/var/lib/tftpboot/pxelinux.0'
default['tftpd']['menu_c32'] = '/var/lib/tftpboot/menu.c32'

# Files needed to TFTP.
if platform_family?('debian')
  default['syslinux']['pxelinux'] = '/usr/lib/syslinux/pxelinux.0'
  default['syslinux']['menu_c32'] = '/usr/lib/syslinux/menu.c32'
elsif platform_family?('rhel')
  default['syslinux']['pxelinux'] = '/usr/share/syslinux/pxelinux.0'
  default['syslinux']['menu_c32'] = '/usr/share/syslinux/menu.c32'
end
default['pxelinux']['menu'] = '/var/lib/tftpboot/pxelinux.cfg/default'

# DHCP configuration
default['dhcp']['config'] = '/etc/dhcp/dhcpd.conf'
default['dhcp']['isc_dhcp'] = '/etc/default/isc-dhcp-server'
default['dhcp']['subnet'] = '192.168.56.0'
default['dhcp']['subnet_mask'] = '255.255.255.0'
default['dhcp']['dynamic_range'] = '192.168.56.100 192.168.56.200'
default['dhcp']['routers'] = '192.168.56.5'
default['dhcp']['broadcast'] = '192.168.56.255'
default['dhcp']['next_server'] = '192.168.56.5'
default['dhcp']['eth'] = 'eth1'

# Services
if platform_family?('debian')
	if platform?('ubuntu') && node['platform_version'] >= '14.04'
		default['services'] = ['isc-dhcp-server', 'tftpd-hpa', 'apache2']
	else
    default['services'] = ['isc-dhcp-server', 'tftpd-hpa']
  end
elsif platform_family?('rhel')
  default['services'] = ['dhcpd', 'xinetd']
end

# Default ISO
default['download']['default_image'] = true
default['apache2']['upstart_init'] = '/etc/init/apache2.conf'