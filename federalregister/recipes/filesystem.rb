#
# Cookbook Name:: federalregister
# Recipe:: filesystem
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

node['federalregister']['mounted_dirs'].each do |config|
  srv = config['service']

  directory config.fetch('mount_point') do
    action :create
    recursive true
    mode config.fetch('mode') { "0755" }
    owner config.fetch('owner')
    group config.fetch('group'){ config.fetch('owner') }
  end

  # mount the directories
  mount config.fetch('path') do
    device config.fetch('mount_point')
    fstype config.fetch('fstype'){ "none" }
    options config.fetch('options'){ "bind" }
    action [:mount, :enable]
  end

  # restart the affected service
  if srv
    service srv do
      action :restart
    end
  end
end

