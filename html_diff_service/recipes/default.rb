#
# Cookbook Name:: html_diff_service
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

require 'yaml'
include_recipe "apt"

# install open jdk/jre
apt_repository 'openjdk-r' do
  uri          'ppa:openjdk-r/ppa'
  distribution node['lsb']['codename']
end

%w(openjdk-8-jdk openjdk-8-jre).each do |pkg|
  package pkg
end

# add git application repo to server
app_config = data_bag_item('applications', node['html_diff_service']['application_name'])[node.chef_environment]
repository_config = app_config['repository']

directory repository_config['directory'] do
  mode 0755
  action :create
  owner repository_config['owner']
  group repository_config['group']
  recursive true
  not_if do FileTest.directory?(repository_config['directory']) end
end

git repository_config['directory'] do
  user repository_config['owner']
  group repository_config['group']
  repository repository_config['url']
  revision repository_config['revision']
  enable_submodules repository_config.fetch('enable_submodules') { false }

  action :sync
  not_if { FileTest.directory?("#{repository_config['directory']}/.git") }
end
