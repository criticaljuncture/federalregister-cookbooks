#
# Cookbook Name:: postfix
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


## set up servers allowed to use this installation as a relay
servers_bag_name = node['postfix']['servers_data_bag_name']
ip_configs = data_bag_item(servers_bag_name, 'ip_addresses')[node.chef_environment]

allowed_ip_addresses = ['127.0.0.0/8'] #sending mail from localhost is ok

node['postfix']['allowed_server_hostnames'].each do |hostname|
  config = ip_configs.select{|c| c["hostname"] == hostname}.first

  allowed_ip_addresses << config["ip_addresses"]
end

node.default['postfix']['main']['mynetworks'] = allowed_ip_addresses.flatten.uniq.join(' ')


## set up our username and password for sendgrid
credentials_bag_name = node['postfix']['credentials_data_bag_name']
sendgrid_credentials = data_bag_item(credentials_bag_name, 'sendgrid')

node.override['postfix']['sasl']['smtp_sasl_user_name'] = sendgrid_credentials['username']
node.override['postfix']['sasl']['smtp_sasl_passwd']    = sendgrid_credentials['password']

include_recipe 'postfix::default'
