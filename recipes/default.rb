#
# Author:: Adam Jacob <adam@opscode.com>
# Author:: Joshua Timberman <joshua@opscode.com>
# Author:: Christopher.Coffey <christopher.coffey@rackspace.com>
#
# Cookbook Name:: rackspace_apache
# Recipe:: default
#
# Copyright 2008-2013, Opscode, Inc.
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

package 'apache2' do
  package_name node['rackspace_apache']['package']
end

service 'apache2' do
  case node['platform_family']
  when 'rhel'
    service_name 'httpd'
    restart_command '/sbin/service httpd restart && sleep 1'
    reload_command '/sbin/service httpd reload && sleep 1'
  when 'debian'
    service_name 'apache2'
    restart_command '/usr/sbin/invoke-rc.d apache2 restart && sleep 1'
    reload_command '/usr/sbin/invoke-rc.d apache2 reload && sleep 1'
  end
  supports [:restart, :reload, :status]
  action :enable
end

if platform_family?('rhel')
  directory node['rackspace_apache']['log_dir'] do
    mode '0755'
  end

  package 'perl'

  cookbook_file '/usr/local/bin/apache2_module_conf_generate.pl' do
    source 'apache2_module_conf_generate.pl'
    mode   '0755'
    owner  'root'
    group  node['rackspace_apache']['root_group']
  end

  %w[sites-available sites-enabled mods-available mods-enabled].each do |dir|
    directory "#{node['rackspace_apache']['dir']}/#{dir}" do
      mode  '0755'
      owner 'root'
      group node['rackspace_apache']['root_group']
    end
  end

  execute 'generate-module-list' do
    command "/usr/local/bin/apache2_module_conf_generate.pl #{node['rackspace_apache']['lib_dir']} #{node['rackspace_apache']['dir']}/mods-available"
    action  :nothing
  end

  %w[a2ensite a2dissite a2enmod a2dismod].each do |modscript|
    template "/usr/sbin/#{modscript}" do
      source "#{modscript}.erb"
      mode  '0700'
      owner 'root'
      group node['rackspace_apache']['root_group']
    end
  end

  # installed by default on centos/rhel, remove in favour of mods-enabled
  %w[proxy_ajp auth_pam authz_ldap webalizer ssl welcome].each do |f|
    file "#{node['rackspace_apache']['dir']}/conf.d/#{f}.conf" do
      action :delete
      backup false
    end
  end

  # installed by default on centos/rhel, remove in favour of mods-enabled
  file "#{node['rackspace_apache']['dir']}/conf.d/README" do
    action :delete
    backup false
  end

  # enable mod_deflate for consistency across distributions
  apache_module 'deflate' do
    conf true
  end
end

%W[
  #{node['rackspace_apache']['dir']}/ssl
  #{node['rackspace_apache']['dir']}/conf.d
  #{node['rackspace_apache']['cache_dir']}
].each do |path|
  directory path do
    mode  '0755'
    owner 'root'
    group node['rackspace_apache']['root_group']
  end
end

# Set the preferred execution binary - prefork or worker
template '/etc/sysconfig/httpd' do
  source   'etc-sysconfig-httpd.erb'
  owner    'root'
  group    node['rackspace_apache']['root_group']
  mode     '0644'
  notifies :restart, 'service[apache2]'
  only_if  { platform_family?('rhel') }
end

template 'apache2.conf' do
  case node['platform_family']
  when 'rhel'
    path "#{node['rackspace_apache']['dir']}/conf/httpd.conf"
  when 'debian'
    path "#{node['rackspace_apache']['dir']}/apache2.conf"
  end
  source   'apache2.conf.erb'
  owner    'root'
  group    node['rackspace_apache']['root_group']
  mode     '0644'
  notifies :restart, 'service[apache2]'
end

template 'apache2-conf-security' do
  path     "#{node['rackspace_apache']['dir']}/conf.d/security.conf"
  source   'security.erb'
  owner    'root'
  group    node['rackspace_apache']['root_group']
  mode     '0644'
  backup   false
  notifies :restart, 'service[apache2]'
end

template 'apache2-conf-charset' do
  path      "#{node['rackspace_apache']['dir']}/conf.d/charset.conf"
  source   'charset.erb'
  owner    'root'
  group    node['rackspace_apache']['root_group']
  mode     '0644'
  backup   false
  notifies :restart, 'service[apache2]'
end

template "#{node['rackspace_apache']['dir']}/ports.conf" do
  source   'ports.conf.erb'
  owner    'root'
  group    node['rackspace_apache']['root_group']
  mode     '0644'
  notifies :restart, 'service[apache2]'
end

template "#{node['rackspace_apache']['dir']}/sites-available/default" do
  source   'default-site.erb'
  owner    'root'
  group    node['rackspace_apache']['root_group']
  mode     '0644'
  notifies :restart, 'service[apache2]'
end

include_recipe 'rackspace_apache::modules'

apache_site 'default' do
  enable node['rackspace_apache']['default_site_enabled']
end

include_recipe 'rackspace_apache::logrotate'

service 'apache2' do
  action :start
end
