#
# Cookbook Name:: kibana3
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
service "iptables" do
  action [ :disable, :stop ]
end 

#read repository
template "install.repo" do
  path "/etc/yum.repos.d/install.repo"
  source "install.repo.erb"
  owner "root"
  group "root"
  mode 0644
end
