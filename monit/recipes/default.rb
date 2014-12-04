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
  worker_config['queue_count'].times do |i|
    name = "resque_worker_#{worker_config['name']}_#{i}"
    pidfile = "#{worker_config['app_location']}/#{worker_config['pidfile_location']}/#{name}.pid"

    monit_check name do
      check_type 'process'
      check_id pidfile
      group worker_config['monit_group']
      start "/usr/bin/env HOME=/home/#{worker_config['user']} /bin/sh -l -c 'cd #{worker_config['app_location']}; nohup bundle exec rake environment resque:work RAILS_ENV=#{node['rails']['environment']} QUEUE=#{worker_config['queue']} INTERVAL=#{worker_config['resque_interval']} VERBOSE=1 PIDFILE=#{pidfile} >> #{worker_config['app_location']}/log/resque_worker_#{worker_config['name']}.log 2>&1'"
      start_as "#{worker_config['user']} and gid #{worker_config['group']}"
      stop "/bin/sh -c 'kill -3 $(cat #{pidfile}) && rm -f #{pidfile}; exit 0;'"
      tests worker_config['tests']
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
