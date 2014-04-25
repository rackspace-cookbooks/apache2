name              'rackspace_apache'
maintainer        'Rackspace US, Inc.'
maintainer_email  'rackspace-cookbooks@rackspace.com'
license           'Apache 2.0'
description       'Installs and configures all aspects of apache2 using Debian style symlinks with helper definitions'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '2.0.1'

depends 'rackspace_logrotate', '~> 2.0'
depends 'rackspace_php', '~> 2.1'
