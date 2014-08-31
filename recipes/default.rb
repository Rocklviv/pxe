#
# Cookbook Name:: chef-pxe
# Recipe:: default
#
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#

if platform_family?("rhel")
  include_recipe 'chef-pxe::rhel'
elsif platform_family?("debian")
  include_recipe 'chef-pxe::deb'
end