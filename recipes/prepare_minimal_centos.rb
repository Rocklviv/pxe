#
# Cookbook Name:: chef-pxe
# Recipe:: prepare_minimal_centos
# Description:: Prepare CentOS 6.5 minimal as default netboot image.
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#
listdirs = [
  node['iso']['mount_dir'],
  node['tftp']['centos_dir'],
  node['tftp']['centos_arch_dir'],
  node['http-chef-pxe']['http_dir'],
  node['http-chef-pxe']['image_dir'],
  node['http-chef-pxe']['image_ks_dir']
]

listdirs.each do |dirs|
  directory dirs do
    recursive true
    action :create
  end
end

web_app "pxe-image-host" do
  server_name node['pxe']['hostname'] 
  docroot "#{node['http-chef-pxe']['http_dir']}"
  allow_override 'All'
  directory_options '+FollowSymLinks'
  cookbook 'apache2'
end

remote_file node['iso']['name'] do
  source "#{node['image']['url']}"
  path "#{node['iso']['tmp_dir']}"
end


mount node['iso']['mount_dir'] do 
  device "#{node['iso']['tmp_dir']}"
  fstype 'iso9660'
  options 'loop,ro'
  action [:mount, :enable]
end

execute 'Copy' do
  command "cp -ar #{node['iso']['mount_dir']}/. #{node['http-chef-pxe']['image_dir']}"
end

remote_file "initrd.img" do
  path "#{node['tftp']['centos_arch_dir']}/initrd.img"
  source "file://#{node['http-chef-pxe']['image_dir']}/images/pxeboot/initrd.img"
end

remote_file "vmlinuz" do
  path "#{node['tftp']['centos_arch_dir']}/vmlinuz"
  source "file:///#{node['http-chef-pxe']['image_dir']}/images/pxeboot/vmlinuz"
end

template "#{node['http-chef-pxe']['image_ks_dir']}/#{node['http-chef-pxe']['ks_filename']}" do 
  source "ks/Centos6-5.minimal.ks"
  action :create
end