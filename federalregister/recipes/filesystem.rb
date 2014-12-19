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

node['federalregister']['mount_points'].each do |config|
  srv = config['service']

  # mount will fail unless the mount point exists already
  directory config.fetch('mount_point') do
    action :create
    recursive true
    mode config.fetch('mode') { "0755" }
    owner config['owner']
    group config.fetch('group'){ config['owner'] }

    not_if do FileTest.directory?(config['mount_point']) end
  end

  # if we're mounting a volume we expect it to be attached,
  # otherwise we want to ensure the device path exists on the system
  unless config['volume']
    directory config.fetch('device') do
      action :create
      recursive true
      mode config.fetch('mode') { "0755" }
      owner config['owner']
      group config.fetch('group'){ config['owner'] }

      not_if do FileTest.directory?(config['device']) end
    end
  end

  # mount the directories
  mount config.fetch('mount_point') do
    device config.fetch('device')
    fstype config.fetch('fstype'){ "none" }
    options config.fetch('options'){ "bind" }
    dump config['dump']
    pass config['pass']

    action [:mount, :enable]

    not_if "cat /proc/mounts | grep '#{config['mount_point']}'"
  end

  # restart the affected service
  if srv
    service srv do
      action :restart
    end
  end
end

