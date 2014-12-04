#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright (C) 2014 Critical Juncture, LLC
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

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe 'nginx::default'

node['nginx']['sites'].each do |site|
  template "#{node['nginx']['dir']}/sites-available/#{site['name']}.conf" do
    source "sites/#{site['name']}.conf.erb"
    variables site: site
  end

  directory "#{node['nginx']['log_dir']}/#{site['name']}"

  nginx_site "#{site['name']}.conf"
end

nginx_site 'default' do
  enable false
  timing :immediate
  only_if { File.exists? "#{node['nginx']['dir']}/sites-available/default" }
end

file "#{node['nginx']['dir']}/sites-available/default" do
  action :delete
end
