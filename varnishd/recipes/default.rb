#
# Cookbook Name:: varnishd_federalregister
# Recipe:: default
#
# Copyright (C) 2015 Critical Juncture, LLC
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

include_recipe "varnishd"

ip_configs = data_bag_item('servers', 'ip_addresses')[node.chef_environment]

# TODO: this is gross and needs a better abstraction for hostnames, aliases, and ports
api_core_config = ip_configs.select{|c| c['hostname'] == 'api-core.fr2.ec2.internal'}.first
api_core_app_config = node['app'].select{|k,v| k.match(api_core_config['aliases'].first)}.values.first
api_core_configs = VarnishHelper.extract_configs(api_core_config, api_core_app_config)

web_config = ip_configs.select{|c| c['hostname'] == 'web.fr2.ec2.internal'}.first
web_app_config = node['app'].select{|k,v| k.match(web_config['aliases'].first)}.values.first
web_configs = VarnishHelper.extract_configs(web_config, web_app_config)

skip_cache_key = data_bag_item('applications', 'federalregister-api-core')[node.chef_environment]['secrets']['varnish']['skip_cache_key']

rewind "template[varnish-vcl]" do
  path '/usr/local/etc/varnish/default.vcl'
  source node[:varnishd][:vcl_source]
  cookbook node[:varnishd][:vcl_cookbook]

  variables api_core_configs: api_core_configs,
    web_configs: web_configs,
    skip_cache_key: skip_cache_key,
    site_hostname: node['federalregister']['varnish']['site_hostname']

  notifies :reload, 'service[varnish]', :delayed
end

rewind "template[varnish-upstart]" do
  path '/etc/init/varnish.conf'
  source 'varnish.conf.erb'
  cookbook "varnishd_federalregister"
  notifies :restart, 'service[varnish]', :delayed
end
