site :opscode
metadata

cookbook 'rackspace_logrotate', github: "rackspace-cookbooks/rackspace_logrotate"

group :integration do
  cookbook "minitest-handler"
  cookbook "runit"
  cookbook 'rackspace_apt', github: "rackspace-cookbooks/rackspace_apt"
  cookbook 'rackspace_yum', github: "rackspace-cookbooks/rackspace_yum"
  cookbook "rackspace_apache", :path => "."
  cookbook "rackspace_apache_test", :path => "./test/cookbooks/apache2_test"
end
