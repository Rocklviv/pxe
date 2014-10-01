#
# Cookbook Name:: pxe
# Recipe:: круд
# Description:: Recipe for all Debian/Ubuntu based OS.
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum'
include_recipe 'tftp'

node['packages'].each do |pkgs| 
	package pkgs do
		action :upgrade
	end
end

service 'iptables' do
	supports :restart => true, :status => true, :reload => true
  action [:disable, :stop]
end

execute 'IPTables open UDP port' do
	command "iptables -A INPUT -i #{node['dhcp']['eth']} -s #{node['dhcp']['subnet']}/24 -p udp --dport 69 -m state --state NEW,ESTABLISHED -j ACCEPT"
end

execute 'IPTables open TCP port' do
	command "iptables -A INPUT -i #{node['dhcp']['eth']} -s #{node['dhcp']['subnet']}/24 -p tcp --dport 69 -m state --state NEW,ESTABLISHED -j ACCEPT"
end

include_recipe 'pxe::common'
