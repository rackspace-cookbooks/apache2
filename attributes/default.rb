#
# Author:: Adam Jacob <adam@opscode.com>
# Author:: Joshua Timberman <joshua@opscode.com>
# Author:: Christopher.Coffey <christopher.coffey@rackspace.com>
#
# Cookbook Name:: rackspace_apache
# Attributes:: default
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

default['rackspace_apache']['root_group'] = 'root'

# default modules (all OS's)
default['rackspace_apache']['default_modules'] = %w[
  status alias auth_basic authn_file authz_default authz_groupfile authz_host authz_user autoindex
  dir env mime negotiation setenvif
]

# additional default modules for rhel platform_family
%w[log_config logio].each do |log_mod|
  default['rackspace_apache']['default_modules'] << log_mod if %w[rhel].include?(node['platform_family'])
end

# Hash for additional modules to be installed
default['rackspace_apache']['additional_module'] = []

# Where the various parts of apache are
case node['platform']
when 'redhat', 'centos'
  default['rackspace_apache']['package']     = 'httpd'
  default['rackspace_apache']['dir']         = '/etc/httpd'
  default['rackspace_apache']['log_dir']     = '/var/log/httpd'
  default['rackspace_apache']['error_log']   = 'error.log'
  default['rackspace_apache']['access_log']  = 'access.log'
  default['rackspace_apache']['user']        = 'apache'
  default['rackspace_apache']['group']       = 'apache'
  default['rackspace_apache']['binary']      = '/usr/sbin/httpd'
  default['rackspace_apache']['docroot_dir'] = '/var/www/html'
  default['rackspace_apache']['cgibin_dir']  = '/var/www/cgi-bin'
  default['rackspace_apache']['icondir']     = '/var/www/icons'
  default['rackspace_apache']['cache_dir']   = '/var/cache/httpd'
  default['rackspace_apache']['pid_file']    = if node['platform_version'].to_f >= 6
                                       '/var/run/httpd/httpd.pid'
                                     else
                                       '/var/run/httpd.pid'
                                     end
  default['rackspace_apache']['lib_dir']     = node['kernel']['machine'] =~ /^i[36]86$/ ? '/usr/lib/httpd' : '/usr/lib64/httpd'
  default['rackspace_apache']['libexecdir']  = "#{node['rackspace_apache']['lib_dir']}/modules"
  default['rackspace_apache']['default_site_enabled'] = false
when 'debian', 'ubuntu'
  default['rackspace_apache']['package']     = 'apache2'
  default['rackspace_apache']['dir']         = '/etc/apache2'
  default['rackspace_apache']['log_dir']     = '/var/log/apache2'
  default['rackspace_apache']['error_log']   = 'error.log'
  default['rackspace_apache']['access_log']  = 'access.log'
  default['rackspace_apache']['user']        = 'www-data'
  default['rackspace_apache']['group']       = 'www-data'
  default['rackspace_apache']['binary']      = '/usr/sbin/apache2'
  default['rackspace_apache']['docroot_dir'] = '/var/www'
  default['rackspace_apache']['cgibin_dir']  = '/usr/lib/cgi-bin'
  default['rackspace_apache']['icondir']     = '/usr/share/apache2/icons'
  default['rackspace_apache']['cache_dir']   = '/var/cache/apache2'
  default['rackspace_apache']['pid_file']    = '/var/run/apache2.pid'
  default['rackspace_apache']['lib_dir']     = '/usr/lib/apache2'
  default['rackspace_apache']['libexecdir']  = "#{node['rackspace_apache']['lib_dir']}/modules"
  default['rackspace_apache']['default_site_enabled'] = false
end

# General settings
default['rackspace_apache']['config']['listen_addresses']  = %w[*]
default['rackspace_apache']['config']['listen_ports']      = %w[80]
default['rackspace_apache']['config']['contact']           = 'ops@example.com'
default['rackspace_apache']['config']['timeout']           = 300
default['rackspace_apache']['config']['keepalive']         = 'On'
default['rackspace_apache']['config']['keepaliverequests'] = 100
default['rackspace_apache']['config']['keepalivetimeout']  = 5

# Security
default['rackspace_apache']['config']['servertokens']    = 'Prod'
default['rackspace_apache']['config']['serversignature'] = 'On'
default['rackspace_apache']['config']['traceenable']     = 'On'

# mod_auth_openids
default['rackspace_apache']['config']['allowed_openids'] = []

# mod_status Allow list, space seprated list of allowed entries.
default['rackspace_apache']['config']['status_allow_list'] = 'localhost ip6-localhost'

# mod_status ExtendedStatus, set to 'true' to enable
default['rackspace_apache']['config']['ext_status'] = false

# mod_info Allow list, space seprated list of allowed entries.
default['rackspace_apache']['config']['info_allow_list'] = 'localhost ip6-localhost'

# Prefork Attributes
default['rackspace_apache']['config']['prefork']['startservers']        = 16
default['rackspace_apache']['config']['prefork']['minspareservers']     = 16
default['rackspace_apache']['config']['prefork']['maxspareservers']     = 32
default['rackspace_apache']['config']['prefork']['serverlimit']         = 400
default['rackspace_apache']['config']['prefork']['maxclients']          = 400
default['rackspace_apache']['config']['prefork']['maxrequestsperchild'] = 10_000

# Worker Attributes
default['rackspace_apache']['config']['worker']['startservers']        = 4
default['rackspace_apache']['config']['worker']['serverlimit']         = 16
default['rackspace_apache']['config']['worker']['maxclients']          = 1024
default['rackspace_apache']['config']['worker']['minsparethreads']     = 64
default['rackspace_apache']['config']['worker']['maxsparethreads']     = 192
default['rackspace_apache']['config']['worker']['threadsperchild']     = 64
default['rackspace_apache']['config']['worker']['maxrequestsperchild'] = 0

# mod_proxy settings
default['rackspace_apache']['config']['proxy']['order']      = 'deny,allow'
default['rackspace_apache']['config']['proxy']['deny_from']  = 'all'
default['rackspace_apache']['config']['proxy']['allow_from'] = 'none'

# mod_ssl specific settings
default['rackspace_apache']['enable_mod_ssl'] = false
default['rackspace_apache']['mod_ssl']['cipher_suite'] = 'RC4-SHA:HIGH:!ADH'
