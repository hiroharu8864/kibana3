#
# Cookbook Name:: asterisk_1_8_ipfax
# Recipe:: rvm
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
source_dir="/usr/local/src"
httpd_dir="/var/www/html"
rpmfile="elasticsearch-0.90.8.noarch.rpm"
sourcefile="kibana-latest.zip"

cookbook_file "#{source_dir}/#{rpmfile}" do
  mode 0644
end

%w{gcc gcc-c++ kernel-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{httpd git-core unzip td-agent}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{java-1.7.0-openjdk java-1.7.0-openjdk-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

cookbook_file "#{httpd_dir}/#{sourcefile}" do
  mode 0644
end

package "elasticsearch" do
  action :install
  source "#{source_dir}/#{rpmfile}"
end

gem_package "fluent-plugin-elasticsearch" do
  gem_binary "/usr/lib64/fluent/ruby/bin/fluent-gem"
  action :install
end

service "httpd" do
  supports :restart => true, :reload => true
  action [ :start, :enable]
end

service "td-agent" do
  supports :restart => true, :reload => true
  action [ :start, :enable]
end

template "td-agent.conf" do
  path "/etc/td-agent/td-agent.conf"
  source "td-agent.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

execute "chmod_http_log" do
  user "root"
  command "/bin/chmod o+rx /var/log/httpd/"
  action :run
end

service "td-agent" do
  supports :restart => true, :reload => true
  action [ :start, :enable]
  subscribes :restart, "template[td-agent.conf]"
end

script "install_rvm" do
  not_if 'which ruby'
  interpreter "bash"
  user "root"
  code <<-EOL
    curl -L https://get.rvm.io | bash -s stable
    source /etc/profile.d/rvm.sh
    rvm install 2.0.0
    rvm use 2.0.0 --default
  EOL
end

script "unzip_kibana" do
  not_if { File.exists?("#{httpd_dir}/kibana-latest") }
  interpreter "bash"
  user "root"
  code <<-EOL
    cd #{httpd_dir}
    unzip #{sourcefile}
  EOL
end
