#
# Cookbook Name:: federalregister
# Recipe:: aws_ebs
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

include_recipe "aws::default"

aws_credentials = data_bag_item('credentials', 'aws')

node['aws']['ebs']['volumes'].each do |vol|
  aws_ebs_volume vol['name'] do
    aws_access_key aws_credentials['aws_access_key_id']
    aws_secret_access_key aws_credentials['aws_secret_access_key']

    size vol['size']
    volume_id vol['volume_id']
    volume_type vol.fetch('volume_type') { 'gp2' }
    piops vol['piops']
    device vol['device']

    action vol['actions']
  end
end
