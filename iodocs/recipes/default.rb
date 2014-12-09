#
# Cookbook Name:: iodocs
# Recipe:: default
#
# Copyright (C) 2012 Critical Juncture, LLC
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

#
# Cookbook Name:: iodocs
# Recipe:: default
#
# Copyright 2012, Critical Juncture, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "nodejs"
include_recipe "redis"

directory node['iodocs']['path'] do
  mode 0755
  action :create
  owner node['iodocs']['user']
  group node['iodocs']['group']
  recursive true
  not_if do FileTest.directory?(node['iodocs']['path']) end
end

git node['iodocs']['path'] do
  user node['iodocs']['user']
  group node['iodocs']['group']
  repository node['iodocs']['repo_url']
  reference node['iodocs']['repo_ref']
  action :sync
end

bash "NPM install iodocs" do
  user "root"
  cwd node['iodocs']['path']
  code <<-EOH
    npm install
    EOH

  not_if do
    system("npm list | grep -q iodocs")
  end
end

#set up variables for service / upstart script
service_name = "iodocs"
service_user = node['iodocs']['user']
service_user_home = (%x[cat /etc/passwd | grep #{service_user} | cut -d":" -f6]).chomp

# Create a node service for this program with upstart
template "/etc/init/#{service_name}.conf" do
  source "iodocs.upstart.erb"
  variables name: service_name,
            path: node['iodocs']['path'],
            script: "/usr/bin/node #{node['iodocs']['path']}/app.js",
            user: service_user,
            user_home: service_user_home,
            args: ""
end

file "/var/log/#{service_name}.log" do
  owner "root"
  group node['iodocs']['group']
  mode "0664"
  action :create
end

file "/var/run/#{service_name}.pid" do
  owner "root"
  group node['iodocs']['group']
  mode "0777"
  action :create
end

service service_name do
  provider Chef::Provider::Service::Upstart
  supports [:start, :stop, :restart]
end


template "#{node['iodocs']['path']}/config.json" do
  source "config.json.erb"
  owner service_user
  group node['iodocs']['group']
  variables :title   => node['iodocs']['title'],
            :address => node['iodocs']['address'],
            :port    => node['iodocs']['port'],
            :debug   => node['iodocs']['debug'],
            :session_secret => node['iodocs']['session_secret'],
            :redis_host     => node['iodocs']['redis']['host'],
            :redis_port     => node['iodocs']['redis']['port'],
            :redis_password => node['iodocs']['redis']['password'],
            :redis_database => node['iodocs']['redis']['database']

  mode "0664"

  notifies :restart, resources(:service => service_name)
end
