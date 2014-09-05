require 'spec_helper'

if ['Debian', 'Ubuntu'].include?(os[:family])
	# Checks installed packages
	describe package('tftpd-hpa') do 
		it { should be_installed }
	end

	describe package('isc-dhcp-server') do 
		it { should be_installed }
	end

	describe package('syslinux') do 
		it { should be_installed }
	end

	# Checks enabled and running services.
	describe service('isc-dhcp-server') do 
		it { should be_enabled }
		it { should be_running }
	end

	describe service('tftpd-hpa') do 
		it { should be_enabled }
		it { should be_running }
	end

elsif os[:family] == 'RedHat'
	# Check installed packages.
	describe package('tftp-server') do 
		it { should be_installed }
	end

	describe package('dhcp') do 
		it { should be_installed }
	end

	describe package('syslinux') do 
		it { should be_installed }
	end

	describe package('xinetd') do 
		it { should be_installed }
	end

	# Checks enabled and running services.
	describe service('dhcpd') do 
		it { should be_enabled }
		it { should be_running }
	end

	describe service('xinetd') do 
		it { should be_enabled }
		it { should be_running }
	end
end

describe port(69) do 
	it { should be_listening }
end

describe file('/var/lib/tftpboot/pxelinux.cfg') do 
	it { should be_directory }
end

describe file('/var/lib/tftpboot/pxelinux.0') do 
	it { should be_file }
end

describe file('/var/lib/tftpboot/menu.c32') do 
	it { should be_file }
end

describe file('/etc/dhcp/dhcpd.conf') do 
	it { should be_file }
	it { should contain 'filename "pxelinux.0";' }
end