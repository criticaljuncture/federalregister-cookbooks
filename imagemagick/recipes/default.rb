#
# Cookbook Name:: imagemagick
# Recipe:: default
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

# dependencies
%w(
  checkinstall
  libx11-dev
  libxext-dev
  zlib1g-dev
  libpng12-dev
  libjpeg-dev
).each do |pkg|
  package pkg
end

remote_file node['imagemagick']['download_path'] do
  source node['imagemagick']['download_url']
  mode "0755"

  not_if do
    File.exists?(node['imagemagick']['download_path'])
  end
end

script "install imagemagick from downloaded package" do
  interpreter "bash"
  user "root"

  code <<-EOH
    apt-get build-dep imagemagick
    cd /tmp
    tar -xzvf #{node['imagemagick']['package_name']}
    cd ImageMagick-#{node['imagemagick']['version']}
    ./configure
    make
    checkinstall -D make install
    ldconfig /usr/local/lib
  EOH

  not_if do
    system("identify --version | grep -q '#{node['imagemagick']['version']}'")
  end
end
