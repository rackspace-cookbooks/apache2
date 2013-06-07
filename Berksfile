site :opscode

metadata

group :integration do
  cookbook "openldap", git: 'git://github.com/opscode-cookbooks/openldap'
  cookbook "minitest-handler"
  cookbook "runit"
  cookbook "apt"
  cookbook "apache2", :path => "."
  cookbook "apache2_test", :path => "./test/cookbooks/apache2_test"
end
