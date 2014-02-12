rackspace_apache Cookbook
================

This cookbook provides a complete Debian/Ubuntu style Apache HTTPD
configuration. Non-Debian based distributions such as Red Hat/CentOS
supported by this cookbook will have a configuration that mimics 
Debian/Ubuntu style as it is easier to manage with Chef.

Debian-style Apache configuration uses scripts to manage modules and
sites (vhosts). The scripts are:

* a2ensite
* a2dissite
* a2enmod
* a2dismod

This cookbook ships with templates of these scripts for non
Debian/Ubuntu platforms. The scripts are used in the __Definitions__
below.

Requirements
============

## Ohai and Chef:

* Ohai: 0.6.12+
* Chef: 0.10.10+

As of v1.2.0, this cookbook makes use of `node['platform_family']` to
simplify platform selection logic. This attribute was introduced in
Ohai v0.6.12. The recipe methods were introduced in Chef v0.10.10. If
you must run an older version of Chef or Ohai, use [version 1.1.16 of
this cookbook](http://community.opscode.com/cookbooks/apache2/versions/1_1_16/downloads).

## Cookbooks:

This cookbook doesn't have direct dependencies on other cookbooks, as
none are needed for the default recipe or the general use cases.

Depending on your OS configuration and security policy, you may need
additional recipes or cookbooks for this cookbook's recipes to
converge on the node. In particular, the following Operating System
settings may affect the behavior of this cookbook:

* apt cache outdated

On Ubuntu/Debian, use Opscode's `apt` cookbook to ensure the package
cache is updated so Chef can install packages, or consider putting
apt-get in your bootstrap process or
[knife bootstrap template](http://wiki.opscode.com/display/chef/Knife+Bootstrap).

## Platforms:

The following platforms and versions are tested and supported using
Opscode's [test-kitchen](http://github.com/opscode/test-kitchen).

* Ubuntu 12.04
* Debian 7.x
* CentOS 6.x
* RHEL 6.x


Tests
=====

This cookbook in the
[source repository](https://github.com/opscode-cookbooks/apache2)
contains minitests.

Please see the CONTRIBUTING file for information on how to add tests
for your contributions.

Attributes
==========

This cookbook uses many attributes, broken up into a few different
kinds.

Platform specific
-----------------

In order to support the broadest number of platforms, several
attributes are determined based on the node's platform. See the
attributes/default.rb file for default values in the case statement at
the top of the file.

* `node['rackspace_apache']['dir']` - Location for the Apache configuration
* `node['rackspace_apache']['log_dir']` - Location for Apache logs
* `node['rackspace_apache']['error_log']` - Location for the default error log
* `node['rackspace_apache']['access_log']` - Location for the default access log
* `node['rackspace_apache']['user']` - User Apache runs as
* `node['rackspace_apache']['group']` - Group Apache runs as
* `node['rackspace_apache']['binary']` - Apache httpd server daemon
* `node['rackspace_apache']['icondir']` - Location for icons
* `node['rackspace_apache']['cache_dir']` - Location for cached files used by Apache itself or recipes
* `node['rackspace_apache']['pid_file']` - Location of the PID file for Apache httpd
* `node['rackspace_apache']['lib_dir']` - Location for shared libraries
* `node['rackspace_apache']['default_site_enabled']` - Default site enabled. Default is false.

General settings
----------------

These are general settings used in recipes and templates. Default
values are noted.

* `node['rackspace_apache']['config']['listen_addresses']` - Addresses that httpd should listen on. Default is any ("*").
* `node['rackspace_apache']['config']['listen_ports']` - Ports that httpd should listen on. Default is port 80.
* `node['rackspace_apache']['config']['contact']` - Value for ServerAdmin directive. Default "ops@example.com".
* `node['rackspace_apache']['config']['timeout']` - Value for the Timeout directive. Default is 300.
* `node['rackspace_apache']['config']['keepalive']` - Value for the KeepAlive directive. Default is On.
* `node['rackspace_apache']['config']['keepaliverequests']` - Value for MaxKeepAliveRequests. Default is 100.
* `node['rackspace_apache']['config']['keepalivetimeout']` - Value for the KeepAliveTimeout directive. Default is 5.
* `node['rackspace_apache']['default_modules']` - Array of module names. This list can be shortened, but do not add new modules here use the `node['rackspace_apache']['additional_modules']` array.
* `node['rackspace_apache']['enable_mod_ssl']` - Set to false by default. Enable to add mod_ssl to the apache configuration.
* `node['rackspace_apache']['enable_mod_proxy']` - Set to false by default. Enable to add mod_proxy to the apache configuration.
* `node['rackspace_apache']['enable_mod_wsgi']` - Set to false by default. Enable to add mod_wsgi to the apache configuration.
* `node['rackspace_apache']['enable_mod_cgi']` - Set to false by default. Enable to add mod_cgi to the apache configuration.
* `node['rackspace_apache']['enable_mod_php5']` - Set to false by default. Enable to add mod_php to the apache configuration.
* `node['rackspace_apache']['additional_modules']` - Array to add additional modules not already listed in default or set as a boleen such as mod_ssl, mod_php, mod_proxy, mod_wsgi, and mod_cgi.

Prefork attributes
------------------

Prefork attributes are used for tuning the Apache HTTPD prefork MPM
configuration.

* `node['rackspace_apache']['config']['prefork']['startservers']` - initial number of server processes to start. Default is 16.
* `node['rackspace_apache']['config']['prefork']['minspareservers']` - minimum number of spare server processes. Default 16.
* `node['rackspace_apache']['config']['prefork']['maxspareservers']` - maximum number of spare server processes. Default 32.
* `node['rackspace_apache']['config']['prefork']['serverlimit']` - upper limit on configurable server processes. Default 400.
* `node['rackspace_apache']['config']['prefork']['maxclients']` - Maximum number of simultaneous connections.
* `node['rackspace_apache']['config']['prefork']['maxrequestsperchild']` - Maximum number of request a child process will handle. Default 10000.

Worker attributes
-----------------

Worker attributes are used for tuning the Apache HTTPD worker MPM
configuration.

* `node['rackspace_apache']['config']['worker']['startservers']` - Initial number of server processes to start. Default 4
* `node['rackspace_apache']['config']['worker']['serverlimit']` - upper limit on configurable server processes. Default 16.
* `node['rackspace_apache']['config']['worker']['maxclients']` - Maximum number of simultaneous connections. Default 1024.
* `node['rackspace_apache']['config']['worker']['minsparethreads']` - Minimum number of spare worker threads. Default 64
* `node['rackspace_apache']['config']['worker']['maxsparethreads']` - Maximum number of spare worker threads. Default 192.
* `node['rackspace_apache']['config']['worker']['maxrequestsperchild']` - Maximum number of requests a child process will handle.


mod\_ssl attributes
-------------------

* `node['rackspace_apache']['config']['mod_ssl']['cipher_suite']` - sets the
  SSLCiphersuite value to the specified string. The default is
  considered "sane" but you may need to change it for your local
  security policy, e.g. if you have PCI-DSS requirements. 

Recipes
=======


default
-------

The default recipe does a number of things to set up Apache HTTPd. It
also includes a number of modules based on the attribute
`node['rackspace_apache']['default_modules']` as recipes.

logrotate
---------

Logrotate adds a logrotate entry for your apache2 logs. This recipe
requires the `logrotate` cookbook; ensure that `recipe[logrotate]` is
in the node's expanded run list.

modules
--------------

Modules add all the required modules to apache. This starts by installing the default array of modules then checks for special and additional modules that need to be installed. The only module of special instest is the `mod_ssl` module, this will append port 443 to the `node['rackspace_apache']['config']['listen_ports']` attribute array and update the ports.conf.


Definitions
===========

The cookbook provides a few definitions. At some point in the future
these definitions may be refactored into lightweight resources and
providers as suggested by
[foodcritic rule FC015](http://acrmp.github.com/foodcritic/#FC015).

apache\_conf
------------

Sets up configuration file for an Apache module from a template. The
template should be in the same cookbook where the definition is used.
This is used by the `apache_module` definition and is not often used
directly.

This will use a template resource to write the module's configuration
file in the `mods-available` under the Apache configuration directory
(`node['rackspace_apache']['dir']`). This is a platform-dependent location. See
__apache\_module__.

### Parameters:

* `name` - Name of the template. When used from the `apache_module`,
  it will use the same name as the module.

### Examples:

Create `#{node['rackspace_apache']['dir']}/mods-available/alias.conf`.

    apache_conf "alias"

apache\_module
--------------

Enable or disable an Apache module in
`#{node['rackspace_apache']['dir']}/mods-available` by calling `a2enmod` or
`a2dismod` to manage the symbolic link in
`#{node['rackspace_apache']['dir']}/mods-enabled`. If the module has a
configuration file, a template should be created in the cookbook where
the definition is used. See __Examples__.

### Parameters:

* `name` - Name of the module enabled or disabled with the `a2enmod` or `a2dismod` scripts.
* `identifier` - String to identify the module for the `LoadModule` directive. Not typically needed, defaults to `#{name}_module`
* `enable` - Default true, which uses `a2enmod` to enable the module. If false, the module will be disabled with `a2dismod`.
* `conf` - Default false. Set to true if the module has a config file, which will use `apache_conf` for the file.
* `filename` - specify the full name of the file, e.g.

### Examples:

Enable the ssl module, which also has a configuration template in `templates/default/mods/ssl.conf.erb`.

    apache_module "ssl" do
      conf true
    end

Enable the php5 module, which has a different filename than the module default:

    apache_module "php5" do
      filename "libphp5.so"
    end

Disable a module:

    apache_module "disabled_module" do
      enable false
    end

See the recipes directory for many more examples of `apache_module`.

apache\_site
------------

Enable or disable a VirtualHost in
`#{node['rackspace_apache']['dir']}/sites-available` by calling a2ensite or
a2dissite to manage the symbolic link in
`#{node['rackspace_apache']['dir']}/sites-enabled`.

The template for the site must be managed as a separate resource. To
combine the template with enabling a site, see `web_app`.

### Parameters:

* `name` - Name of the site.
* `enable` - Default true, which uses `a2ensite` to enable the site. If false, the site will be disabled with `a2dissite`.

web\_app
--------

Manage a template resource for a VirtualHost site, and enable it with
`apache_site`. This is commonly done for managing web applications
such as Ruby on Rails, PHP or Django, and the default behavior
reflects that. However it is flexible.

This definition includes some recipes to make sure the system is
configured to have Apache and some sane default modules:

* `apache2`
* `apache2::mod_rewrite`
* `apache2::mod_deflate`
* `apache2::mod_headers`

It will then configure the template (see __Parameters__ and
__Examples__ below), and enable or disable the site per the `enable`
parameter.

### Parameters:

Current parameters used by the definition:

* `name` - The name of the site. The template will be written to
  `#{node['rackspace_apache']['dir']}/sites-available/#{params['name']}.conf`
* `cookbook` - Optional. Cookbook where the source template is. If
  this is not defined, Chef will use the named template in the
  cookbook where the definition is used.
* `template` - Default `web_app.conf.erb`, source template file.
* `enable` - Default true. Passed to the `apache_site` definition.

Additional parameters can be defined when the definition is called in
a recipe, see __Examples__.

### Examples:

All parameters are passed into the template. You can use whatever you
like. The apache2 cookbook comes with a `web_app.conf.erb` template as
an example. The following parameters are used in the template:

* `server_name` - ServerName directive.
* `server_aliases` - ServerAlias directive. Must be an array of aliases.
* `docroot` - DocumentRoot directive.
* `application_name` - Used in RewriteLog directive. Will be set to the `name` parameter.
* `directory_index` - Allow overriding the default DirectoryIndex setting, optional
* `directory_options` - Override Options on the docroot, for example to add parameters like Includes or Indexes, optional.
* `allow_override` - Modify the AllowOverride directive on the docroot to support apps that need .htaccess to modify configuration or require authentication.

To use the default web_app, for example:

    web_app "my_site" do
      server_name node['hostname']
      server_aliases [node['fqdn'], "my-site.example.com"]
      docroot "/srv/www/my_site"
    end

The parameters specified will be used as:

* `@params[:server_name]`
* `@params[:server_aliases]`
* `@params[:docroot]`

In the template. When you write your own, the `@` is significant.

For more information about Definitions and parameters, see the
[Chef Wiki](http://wiki.opscode.com/display/chef/Definitions)

Usage
=====

Using this cookbook is relatively straightforward. Add the desired
recipes to the run list of a node, or create a role. Depending on your
environment, you may have multiple roles that use different recipes
from this cookbook. Adjust any attributes as desired. For example, to
create a basic role for web servers that provide both HTTP and HTTPS:

    % cat roles/webserver.rb
    name "webserver"
    description "Systems that serve HTTP and HTTPS"
    run_list(
      "recipe[apache2]",
      "recipe[apache2::mod_ssl]"
    )
    default_attributes(
      "apache" => {
        "listen_ports" => ["80", "443"]
      }
    )

For examples of using the definitions in your own recipes, see their
respective sections above.

License and Authors
===================

* Author:: Adam Jacob <adam@opscode.com>
* Author:: Joshua Timberman <joshua@opscode.com>
* Author:: Bryan McLellan <bryanm@widemile.com>
* Author:: Dave Esposito <esposito@espolinux.corpnet.local>
* Author:: David Abdemoulaie <github@hobodave.com>
* Author:: Edmund Haselwanter <edmund@haselwanter.com>
* Author:: Eric Rochester <err8n@virginia.edu>
* Author:: Jim Browne <jbrowne@42lines.net>
* Author:: Matthew Kent <mkent@magoazul.com>
* Author:: Nathen Harvey <nharvey@customink.com>
* Author:: Ringo De Smet <ringo.de.smet@amplidata.com>
* Author:: Sean OMeara <someara@opscode.com>
* Author:: Seth Chisamore <schisamo@opscode.com>
* Author:: Gilles Devaux <gilles@peerpong.com>
* Author:: Christopher Coffey <christopher.coffey@rackspace.com.

* Copyright:: 2014, Rackspace US, Inc.
* Copyright:: 2009-2012, Opscode, Inc
* Copyright:: 2011, Atriso
* Copyright:: 2011, CustomInk, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
