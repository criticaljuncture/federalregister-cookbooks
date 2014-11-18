#
# Cookbook Name:: user_federalregister
# Provider:: bash_profile
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

use_inline_resources

action :create do
  profile_content = FederalRegisterTemplatizer.new(node.to_hash, new_resource.content).render

  f = file new_resource.path do
    content profile_content
    owner new_resource.user
    group new_resource.group
    mode new_resource.mode
  end

  new_resource.updated_by_last_action(f.updated_by_last_action?)
end

private

class FederalRegisterTemplatizer
  include ERB::Util
  attr_reader :node, :template

  def initialize(node, template)
    @node = node
    @template = template
  end

  def render
    ERB.new(template).result(binding)
  end
end
