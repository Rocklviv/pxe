#
# Cookbook Name:: pxe
# Recipe:: common
# Description:: Common recipe for RedHat and Debian based OS.
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apache2'

template node['apache2']['upstart_init'] do 
  source 'upstart-apache2.conf.erb'
  owner 'root'
  group 'root'

  action :create
  only_if { platform?('ubuntu') && node['platform_version'] >= '14.04' }
end

template node['dhcp']['config'] do
  source 'dhcpd.conf.erb'
  owner 'root'
  group 'root'

  variables(
    "config" => node['dhcp']
  )
  action :create
end

template node['dhcp']['isc_dhcp'] do
  source 'isc-dhcp-server.erb'
  owner 'root'
  group 'root'

  variables(
    "eth" => node['dhcp']['eth']
  )
  action :create
end

remote_file "pxelinux.0" do
	not_if { File.exist?('/var/lib/tftpboot/pxelinux.0') }
	path node['tftpd']['pxelinux']
  source "file://#{node['syslinux']['pxelinux']}"
  action :delete
end

directory node['tftpd']['pxe_cfg'] do
	action :delete
	action :create
end

template node['pxelinux']['menu'] do
  source 'default.erb'
  action :create

  variables(
    'config' => node['pxe']['hostname']
  )
end

remote_file "copy_pxelinux.0" do
  path node['tftpd']['pxelinux']
  source "file://#{node['syslinux']['pxelinux']}"
end

remote_file "copy_menu.c32" do
  path node['tftpd']['menu_c32']
  source "file://#{node['syslinux']['menu_c32']}"
end

if node['download']['default_image']
  include_recipe 'pxe::prepare_minimal_centos'
end

node['services'].each do |srvs|
  service srvs do
    provider Chef::Provider::Service::Upstart if platform?("ubuntu") && node["platform_version"].to_f >= 14.04
    supports :restart => true, :status => true, :reload => true
    #if platform?("ubuntu") && node["platform_version"].to_f >= 14.04
    #  action [:restart]
    #else
    action [:enable, :restart]
    #end
  end
end
