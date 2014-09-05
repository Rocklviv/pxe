require 'spec_helper'

if ['Debian', 'Ubuntu'].include?(os[:family])

	describe package('apache2') do
		it { should be_installed }
	end

	describe service('apache2') do 
		it { should be_enabled }
		it { should be_running }
	end

	describe file('/etc/apache2/sites-available/pxe-image-host.conf') do 
		it { should be_file }
		it { should contain 'DocumentRoot /var/www/html/' }
	end
elsif os[:family] == 'RedHat'

	describe package('httpd') do 
		it { should be_installed }
	end

	describe service('httpd') do 
		it { should be_enabled }
		it { should be_running }
	end

	describe file('/etc/httpd/sites-available/pxe-image-host.conf') do 
		it { should be_file }
		it { should contain 'DocumentRoot /var/www/html/' }
	end
end

#describe port(90) do 
#	it { should be_listening }
#end

describe file('/var/www/html') do 
	it { should be_directory }
end