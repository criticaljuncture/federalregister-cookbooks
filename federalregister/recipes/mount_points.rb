#
# Cookbook Name:: federalregister
# Recipe:: mount_points
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

node['mount_points'].each do |mp|
  directory mp['mount_point'] do
    owner mp['owner']
    group mp['group']
    mode mp['mode'] || "0755"
    recursive true
    action :create
    not_if do FileTest.directory?(mp['mount_point']) end
  end

  mount mp['mount_point'] do
    device mp['device']
    fstype mp['fstype']
    options mp['options']
    dump mp['dump']
    pass mp['pass']

    action [:enable, :mount]

    not_if "cat /proc/mounts | grep '#{mp['mount_point']}'"
  end
end
