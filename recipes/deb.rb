#
# Cookbook Name:: pxe
# Recipe:: deb
# Description:: Recipe for all Debian/Ubuntu based OS.
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'tftp'

# Installing all necesary packages
node['packages'].each do |pkgs|
	package pkgs do 
		action :upgrade
	end
end

include_recipe 'pxe::common'
