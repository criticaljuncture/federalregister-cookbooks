#
# Cookbook Name:: varnishd_federalregister
#
# Copyright (C) 2015 Critical Juncture, LLC
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

module VarnishHelper
  def self.extract_configs(config, app_config)
    ip_addresses = config['ip_addresses']

    if ip_addresses.size > 1
      use_index = true
    end

    configs = []
    port = app_config['port']

    ip_addresses.each_with_index do |ip_address, index|
      hostname = config['hostname']
      aliases = config['aliases']

      if use_index
        parts = hostname.split('.')
        parts[0] = "#{parts[0]}-#{index + 1}"
        hostname = parts.join('.')

        aliases = aliases.map{|a| "#{a}-#{index + 1}"}
      end

      configs << {"alias" => aliases.first.gsub('-', '_'), "hostname" => hostname, "port" => port}
    end

    configs
  end
end
