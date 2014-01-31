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

if node['rackspace_apache']['default_modules'].include('status')
  rackspace_apache_module 'status' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include('alias')
  rackspace_apache_module 'alias' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include('auth_basic')
  rackspace_apache_module 'auth_basic'
end

if node['rackspace_apache']['default_modules'].include('authn_file')
  rackspace_apache_module 'authn_file'
end

if node['rackspace_apache']['default_modules'].include('authz_default')
  rackspace_apache_module 'authz_default'
end

if node['rackspace_apache']['default_modules'].include('authz_groupfile')
  rackspace_apache_module 'authz_groupfile'
end

if node['rackspace_apache']['default_modules'].include('authz_host')
  rackspace_apache_module 'authz_host'
end

if node['rackspace_apache']['default_modules'].include('authz_user')
  rackspace_apache_module 'authz_user'
end

if node['rackspace_apache']['default_modules'].include('autoindex')
  rackspace_apache_module 'autoindex' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include('dir')
  rackspace_apache_module 'dir' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include('env')
  rackspace_apache_module 'env'
end

if node['rackspace_apache']['default_modules'].include('mime')
  rackspace_apache_module 'mime' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include('negotiation')
  rackspace_apache_module 'negotiation' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include('setenvif')
  rackspace_apache_module 'setenvif' do
    conf true
  end
end

if node['rackspace_apache']['default_modules'].include('log_config')
  rackspace_apache_module 'log_config'
end

if node['rackspace_apache']['default_modules'].include('logio')
  rackspace_apache_module 'logio'
end

# checks for additional standard modules to install





