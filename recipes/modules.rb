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

if node['rackspace_apache']['default_modules'].include?('rewrite')
  apache_module 'rewrite'
end

# checks for additional modules to install
if node['rackspace_apache']['enable_mod_proxy'] == true
  apache_module 'proxy' do
    conf true
  end
end

if node['rackspace_apache']['enable_mod_ssl'] == true
  unless node['rackspace_apache']['config']['listen_ports'].include?('443')
    node.set['rackspace_apache']['config']['listen_ports'] = node['rackspace_apache']['config']['listen_ports'] + ['443']
  end

  if platform_family?('rhel')
    package 'mod_ssl' do
      notifies :run, 'execute[generate-module-list]', :immediately
    end

    file "#{node['rackspace_apache']['dir']}/conf.d/ssl.conf" do
      action :delete
      backup false
    end
  end

  template "#{node['rackspace_apache']['dir']}/ports.conf" do
    cookbook node['rackspace_apache']['template_cookbook']['ports']
    source 'ports.conf.erb'
    mode '0644'
    notifies :restart, 'service[apache2]'
  end

  apache_module 'ssl' do
    conf true
  end
end

if node['rackspace_apache']['enable_mod_wsgi'] == true
  case node['platform_family']
  when 'debian'
    package 'libapache2-mod-wsgi'
  when 'rhel'
    package 'mod_wsgi' do
      notifies :run, 'execute[generate-module-list]', :immediately
    end
  end

  file "#{node['rackspace_apache']['dir']}/conf.d/wsgi.conf" do
    action :delete
    backup false
  end

  apache_module 'wsgi'
end

node['rackspace_apache']['enable_mod_cgi'] && apache_module('cgi')

if node['rackspace_apache']['enable_mod_php5'] == true
  case node['platform_family']
  when 'debian'
    package 'libapache2-mod-php5'
  when 'rhel'
    include_recipe 'rackspace_php::default'
    package 'php' do
      notifies :run, 'execute[generate-module-list]', :immediately
    end
  end

  file "#{node['rackspace_apache']['dir']}/conf.d/php.conf" do
    action :delete
    backup false
  end

  apache_module 'php5' do
    case node['platform_family']
    when 'rhel'
      conf true
      filename 'libphp5.so'
    end
  end
end
