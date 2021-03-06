#
# Cookbook Name:: apt_federalregister
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

include_recipe "apt"

if node['apt']['repositories']
  node['apt']['repositories'].each do |name, config|
    apt_repository name do
      uri          config['uri']
      distribution node['lsb']['codename']

      notifies :run, "execute[apt-get update]", :immediately
    end
  end
end

node['apt']['packages'].each do |apt_package|
  package apt_package
end
