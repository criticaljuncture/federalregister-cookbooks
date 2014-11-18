#
# Cookbook Name:: user_federalregister
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

include_recipe 'user::data_bag'

# mimic user data bag recipe to get our array of users

bag = node['user']['data_bag_name']

user_array = node
node['user']['user_array_node_attr'].split("/").each do |hash_key|
  user_array = user_array.send(:[], hash_key)
end

# use our array of users to upload ssh private keys and profiles if specified
Array(user_array).each do |i|
  u = data_bag_item(bag, i.gsub(/[.]/, '-'))
  username = u['username'] || u['id']
  home_dir = "#{node['user']['home_root']}/#{username}"

  if u['ssh_private_keys']
    Array(u['ssh_private_keys']).each do |private_key|
      file "#{home_dir}/.ssh/#{private_key['name']}" do
        content private_key['content']
        owner username
        group username
        mode '600'
      end
    end
  end

  if u['bash_profile']
    user_federalregister_bash_profile "#{home_dir}/.bash_profile" do
      user username
      group username
      content u['bash_profile']
    end
  end
end

