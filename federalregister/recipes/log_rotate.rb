#
# Cookbook Name:: federalregister
# Recipe:: log_rotate
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

include_recipe "s3cmd_federalregister"

logrotate_config_path = "/etc/logrotate.d"

node['federalregister']['logrotate']['remove'].each do |name|
  file "#{logrotate_config_path}/#{name}" do
    action :delete

    only_if { File.exists?("#{logrotate_config_path}/#{name}") }
  end
end

node['federalregister']['logrotate']['configs'].each do |config|
  template "#{logrotate_config_path}/#{config.fetch(:name)}" do
    source config.fetch(:template)
    variables :s3cmd     => '/usr/bin/s3cmd',
              :bucket    => config.fetch(:bucket),
              :name      => config.fetch(:name),
              :log_path  => config.fetch(:path),
              :interval  => config.fetch(:interval) { 'daily' },
              :keep_for  => config.fetch(:keep_for) { 7 }
    mode 0644
    owner "root"
    group "root"
  end
end
