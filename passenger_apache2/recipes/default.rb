#
# Cookbook Name:: passenger_apache2_federalregister
# Recipe:: default
#

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "passenger_apache2"

rewind "#{node['apache']['dir']}/mods-available/passenger.conf" do
    cookbook 'passenger_apache2_federalregister'
    source 'passenger.conf.erb'
    owner 'root'
    group 'root'
    mode 0644
end

