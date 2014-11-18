#
# Cookbook Name:: user_federalregister
# Resource:: bash_profile
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

actions :create

attribute :path,    :kind_of => String, :name_attribute => true
attribute :content, :kind_of => String, :required => true
attribute :user,    :kind_of => String, :required => true
attribute :group,   :kind_of => String, :required => true
attribute :mode,    :kind_of => [String, Integer], :default => '0644'

def initialize(*args)
  super
  @action = :create
end
