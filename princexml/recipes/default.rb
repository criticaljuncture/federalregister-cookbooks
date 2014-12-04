#
# Cookbook Name:: princexml
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

# dependencies
%w(
  libc6
  libtiff4
  libgif4
  libcurl3
  libfontconfig1
  libjpeg8
).each do |pkg|
  package pkg
end

remote_file node['princexml']['download_path'] do
  source node['princexml']['download_url']
  mode "0755"

  not_if do
    File.exists?(node['princexml']['download_path'])
  end
end

script "install prince from downloaded package" do
  interpreter "bash"
  user "root"
  code <<-EOH
    dpkg -i #{node['princexml']['download_path']}
    EOH
  not_if do
    system("prince --version | grep -q '#{node['princexml']['version']}'")
  end
end

file node['princexml']['license_location'] do
  content data_bag_item('credentials', 'princexml')['license']
  owner "root"
end

if node['princexml']['fonts'].length > 0
  node['princexml']['fonts'].each do |font_family, fonts|
    directory "/usr/share/fonts/truetype/#{font_family}" do
      owner 'root'
      group 'root'
      mode 0755
      recursive true
      action :create
      not_if do File.directory?("/usr/share/fonts/truetype/#{font_family}") end
    end

    fonts.each do |font|
      cookbook_file "/usr/share/fonts/truetype/#{font_family}/#{font}.ttf" do
        source "#{font_family}/#{font}.ttf"
        mode 0644
        owner 'root'
        group 'root'

        not_if do
          File.exists?("/usr/share/fonts/truetype/#{font_family}/#{font}.ttf")
        end
      end
    end
  end

  execute "update font cache" do
    user "root"
    command "fc-cache -f -v"
  end
end
