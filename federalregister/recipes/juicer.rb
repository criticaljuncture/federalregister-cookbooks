#
# Cookbook Name:: federalregister
# Recipe:: juicer
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

package "openjdk-7-jre-headless"

execute "install closure compiler for juicer" do
  user "deploy"
  group "deploy"
  command "bundle exec juicer install closure_compiler"
  cwd "/var/www/apps/federalregister-api-core"

  not_if { FileTest.directory?('/home/deploy/.juicer/lib/closure_compiler') }
end
