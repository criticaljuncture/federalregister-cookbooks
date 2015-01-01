#
# Cookbook Name:: federalregister
# Recipe:: application
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

require 'yaml'

node[:federalregister][:applications].each do |application_name|
  app_config = data_bag_item('applications', application_name)[node.chef_environment]

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
  end

  if app_config['config']['files'].length > 0
    app_config['config']['files'].each do |filename|
      template "#{[repository_config['directory'], app_config['config']['relative_path'], filename].reject(&:empty?).compact.join('/')}" do
        source "#{filename}.erb"
        variables :config => app_config
        user repository_config['owner']
        group repository_config['group']
      end
    end
  end

  if app_config['config']['permissions'] && app_config['config']['permissions'].length > 0
    app_config['config']['permissions'].each do |config|
      if FileTest.directory?(config['path'])
        recursive = config.fetch('recursive') { false }
        recursive = recursive ? "-R" : ""

        execute "change permissions on #{config['path']}" do
          command "chown #{recursive} #{config['user']}:#{config['group']} #{config['path']}"
        end
      else
        execute "change permissions on #{config['path']}" do
          command "chown #{config['user']}:#{config['group']} #{config['path']}"
        end
      end
    end
  end
end

# this is a requirement under our current version of ffi-hunspell gem
# the dictionaries aren't in the same place in newer ubuntu versions
# as they were in the past. Once ruby is upgraded we can update the gem
# (which has correct paths) and remove this link.
link "/usr/share/myspell" do
  to "/usr/share/hunspell"
  only_if "dpkg-query -W hunspell"
end
