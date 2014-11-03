#
# Cookbook Name:: s3cmd_federalregister
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

credentials_bag_name = node['s3cmd']['credentials_data_bag_name']
credential_keys = data_bag(credentials_bag_name)

include_recipe 's3cmd'

node['s3cmd']['users'].each do |user|
  home = user == 'root' ? "/root" : "/home/#{user}"

  if credential_keys.include?('aws')
    aws_credentials = data_bag_item(credentials_bag_name, 'aws')
    node.override['s3cmd']['aws_access_key_id'] = aws_credentials['aws_access_key_id']
    node.override['s3cmd']['aws_secret_access_key'] = aws_credentials['aws_secret_access_key']
  end

  template "#{home}/.s3cfg" do
    cookbook 's3cmd_federalregister'
    source "s3cfg.erb"
    owner user
    group user
    mode 0655
  end
end
