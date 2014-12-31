#
# Cookbook Name:: monit
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

include_recipe "monit-ng::default"

node['monit']['resque_workers'].each do |worker_config|
  directory "#{worker_config['app_location']}/lib/scripts" do
    user worker_config['user']
    group worker_config['group']
    recursive true
    mode 0777
  end

  worker_config['queue_count'].times do |i|
    name = "resque_worker_#{worker_config['name']}_#{i}"
    pidfile = "#{worker_config['app_location']}/#{worker_config['pidfile_location']}/#{name}.pid"

    monit_check name do
      check_type 'process'
      check_id pidfile
      group worker_config['monit_group']
      start "/usr/bin/env HOME=/home/deploy /bin/sh -l -c '/var/www/apps/federalregister-api-core/lib/scripts/#{name}.sh'"
      start_as "#{worker_config['user']} and gid #{worker_config['group']}"
      stop "/bin/sh -c 'kill -3 $(cat #{pidfile}) && rm -f #{pidfile}; exit 0;'"
      tests worker_config['tests']
    end

    file "#{worker_config['app_location']}/lib/scripts/#{name}.sh" do
      content <<-sh
#!/usr/bin/env bash
source /usr/local/rvm/environments/ree-1.8.7-2012.02

cd #{worker_config['app_location']}
nohup #{worker_config['rvm_wrapper_path']}/bundle exec rake environment resque:work RAILS_ENV=#{node['rails']['environment']} QUEUE=#{worker_config['queue']} INTERVAL=#{worker_config['resque_interval']} VERBOSE=1 PIDFILE=#{pidfile} >> #{worker_config['app_location']}/log/resque_worker_#{worker_config['name']}.log 2>&1 &
sh
      mode 0775
      user worker_config['user']
      group worker_config['group']
    end
  end
end

monit_check 'redis' do
  check_type 'process'
  check_id  "/var/run/redis.pid"
  group 'redis'
  start "/usr/local/bin/redis-server /etc/redis/redis.conf"
  stop "/bin/bash -c 'echo SHUTDOWN | /usr/local/bin/redis-cli'"
  tests node['monit']['redis']['tests']
end

monit_check 'iodocs' do
  check_type 'process'
  check_id '/var/run/iodocs.pid'
  group 'iodocs'
  start "/sbin/start iodocs"
  stop "/sbin/start iodocs"
  tests node['monit']['iodocs']['tests']
end
