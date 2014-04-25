maintainer       'Christopher Coffey'
maintainer_email 'christopher.coffey@rackspace.com'
license          'Apache 2.0'
description      'Acceptance tests for rackspace_apache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends          'rackspace_apache'
depends          'rackspace_yum'

recipe           'apache_test::default', 'Test example for default recipe'
recipe           'apache_test::mod_ssl', 'Test example for SSL'

%w(debian rhel centos ubuntu).each do |os|
  supports os
end
