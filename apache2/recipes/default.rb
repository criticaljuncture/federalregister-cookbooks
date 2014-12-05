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

# create directory for basic auth
directory node['apache2']['htpasswd_dir'] do
  mode 0755
  action :create
end

# add appropriate vhosts
node[:apache][:vhosts].each do |vhost|
  vhost_data_bag_item = data_bag_item('applications', vhost)[node.chef_environment]

  template "#{node[:apache][:dir]}/sites-available/#{vhost}" do
    source "#{node[:app][vhost][:conf_file]}.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables vhost: vhost,
      vhost_data_bag_item: vhost_data_bag_item
    notifies :restart, resources(service: "apache2")
  end

  # create a user/pass combo if provided
  if node['app'][vhost]['http_basic']
    http_basic = vhost_data_bag_item['http_basic']

    htpasswd_options = ["-b"] #batch
    unless File.exists?(node['apache2']['htpasswd_file'])
      htpasswd_options << "c" #create file
    end

    execute "create basic auth username/password for #{http_basic['username']}" do
      command "htpasswd #{htpasswd_options.join('')} #{node['apache2']['htpasswd_file']} #{http_basic['username']} #{http_basic['password']}"
    end
  end

  apache_site vhost do
    action :enable
  end
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
    enable false
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
