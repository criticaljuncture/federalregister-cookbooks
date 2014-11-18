#
# Cookbook Name:: apache2_federalregister
# Recipe:: default
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# run default setup
include_recipe "apache2"


# add appropriate vhosts
node[:apache][:vhosts].each do |vhost|
  template "#{node[:apache][:dir]}/sites-available/#{vhost}" do
    source "#{node[:app][vhost][:conf_file]}.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables :vhost => vhost
    notifies :restart, resources(service: "apache2")
  end

  apache_site vhost do
    action :enable
  end
end

# create directory for basic auth
directory '/etc/apache2/passwd' do
  mode 0755
  action :create
end

node[:apache][:enable_modules].each do |mod|
  module_recipe_name = mod =~ /^mod_/ ? mod : "mod_#{mod}"
  include_recipe "apache2::#{module_recipe_name}"
end

# create a configuration for custom log formats
cookbook_file "#{node[:apache][:dir]}/conf.d/log_formats.conf" do
  source "log_formats.conf"
  owner "root"
  group "root"
  mode 0644
  action :create
  notifies :restart, resources(service: "apache2")
end

# remove defaults
%w(000-default default-ssl).each do |site|
  apache_site site do
    enable :false
  end
end

# ensure apache is reloaded before we remove the default files next
service "apache2" do
  action :reload
end

%w(
  /var/www/index.html
  /etc/apache2/sites-available/default
  /etc/apache2/sites-available/default-ssl).each do |path|
    file path do
      action :delete
    end
end
