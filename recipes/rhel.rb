#
# Cookbook Name:: pxe
# Recipe:: rhel
# Description:: Recipe for all RHEL based OS.
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'tftp'
include_recipe 'iptables'

node['packages'].each do |pkgs| 
	package pkgs do
		action :upgrade
	end
end

iptables_rule "ssh"
iptables_rule "dhcp_port"
iptables_rule "httpd"

include_recipe 'pxe::common'
