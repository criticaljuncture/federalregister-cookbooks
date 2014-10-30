#
# Cookbook Name:: apache2_federalregister
# Recipe:: default
#

# run default setup
include_recipe "apache2"


# add appropriate vhosts
node[:apache][:vhosts].each do |vhost|
  template "#{node[:apache][:dir]}/sites-available/#{vhost}" do
    source "#{vhost}.conf.erb"
    owner "root"
    group "root"
    mode 0644
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

