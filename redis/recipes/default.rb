#
# Cookbook Name:: redis_federalregister
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

include_recipe "redis::install_from_release"
include_recipe "redis::default"

standard_dirs('redis.server') do
  directories   :conf_dir, :log_dir, :data_dir
end

rewind "template[#{node[:redis][:conf_dir]}/redis.conf]" do
  source        "redis.conf.erb"
  cookbook      "redis_federalregister"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server]
end
