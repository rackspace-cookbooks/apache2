# Author:: Christopher.Coffey <christopher.coffey@rackspace.com>
#
# Cookbook Name:: rackspace_apache
# Recipe:: modules
#
# Copyright 2014, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# checks to see if module is listed in default_modules list and if so install.

if node['rackspace_apache']['default_modules'].include?('status')
  apache_module 'status' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include?('alias')
  apache_module 'alias' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include?('auth_basic')
  apache_module 'auth_basic'
end

if node['rackspace_apache']['default_modules'].include?('authn_file')
  apache_module 'authn_file'
end

if node['rackspace_apache']['default_modules'].include?('authz_default')
  apache_module 'authz_default'
end

if node['rackspace_apache']['default_modules'].include?('authz_groupfile')
  apache_module 'authz_groupfile'
end

if node['rackspace_apache']['default_modules'].include?('authz_host')
  apache_module 'authz_host'
end

if node['rackspace_apache']['default_modules'].include?('authz_user')
  apache_module 'authz_user'
end

if node['rackspace_apache']['default_modules'].include?('autoindex')
  apache_module 'autoindex' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include?('dir')
  apache_module 'dir' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include?('env')
  apache_module 'env'
end

if node['rackspace_apache']['default_modules'].include?('mime')
  apache_module 'mime' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include?('negotiation')
  apache_module 'negotiation' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include?('setenvif')
  apache_module 'setenvif' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include?('log_config')
  apache_module 'log_config'
end

if node['rackspace_apache']['default_modules'].include?('logio')
  apache_module 'logio'
end

# checks for additional modules to install






