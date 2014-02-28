Description
===========

This cookbook defines acceptance tests for rackspace_apache. It includes:

* Recipes that configure individual modules for use in order to be tested.

Requirements
============

## Cookbooks:

This cookbook depends on the `rackspace_apache` cookbook. 
## Platforms:

* Ubuntu 12.04
* CentOS 6.x
* RedHat EL 6.x
* Debian 7.x

Attributes
==========

* `node['apache_test']['auth_username']` - The username of the user for testing
  authentication and authorization.
* `node['apache_test']['auth_password']` - The password of the user for testing
  authentication and authorization.
* `node['apache_test']['cache_expiry_seconds']` - The cache expiry time in
  seconds.
* `node['apache_test']['app_dir']` - The local directory where test applications
  will be deployed.
* `node['apache_test']['cgi_dir']` - The local directory where CGI applications
  will be deployed.
* `node['apache_test']['root_dir']` - The root directory of the webserver.
* `node['apache_test']['remote_host_ip']` - The remote host IP address for
  authorization.

Recipes
=======

* `default` - Simply includes apache2::default for a vanilla apache install.
* `mod_auth_basic` - Adds a web_app behind basic authentication for testing.
* `mod_ssl` - Adds a self-signed SSL certificate and default website for testing.

License and Authors
===================

Author:: Andrew Crump <andrew@kotirisoftware.com>
Author:: Christopher Coffey ,christopher.coffey@rackspace.com>

    Copyright:: 2012, Opscode, Inc
    Copyright:: 2014, Rackspace US, Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
