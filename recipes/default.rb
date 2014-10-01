#
# Cookbook Name:: pxe
# Recipe:: default
#
# Copyright (C) 2014 Denis Chekirda
#
# All rights reserved - Do Not Redistribute
#

if platform_family?("rhel")
  include_recipe 'pxe::rhel'
elsif platform_family?("debian")
  include_recipe 'pxe::deb'
end
