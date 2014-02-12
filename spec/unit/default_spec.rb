# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_apache::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

  it 'installs perl package' do
    expect(chef_run).to install_package('perl')
  end

  it 'creates /usr/local/bin/apache2_module_conf_generate.pl' do
    expect(chef_run).to render_file('/usr/local/bin/apache2_module_conf_generate.pl')
  end

  it 'create /etc/httpd/sites-available' do
    expect(chef_run).to create_directory('/etc/httpd/sites-available').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'create /etc/httpd/sites-enabled' do
    expect(chef_run).to create_directory('/etc/httpd/sites-enabled').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'create /etc/httpd/mods-available' do
    expect(chef_run).to create_directory('/etc/httpd/mods-available').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'create /etc/httpd/mods-enabled' do
    expect(chef_run).to create_directory('/etc/httpd/mods-enabled').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'creates /usr/sbin/a2ensite' do
    expect(chef_run).to create_template('/usr/sbin/a2ensite').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'creates /usr/sbin/a2dissite' do
    expect(chef_run).to create_template('/usr/sbin/a2dissite').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'creates /usr/sbin/a2enmod' do
    expect(chef_run).to create_template('/usr/sbin/a2enmod').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'creates /usr/sbin/a2dismod' do
    expect(chef_run).to create_template('/usr/sbin/a2dismod').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'create /etc/httpd/ssl' do
    expect(chef_run).to create_directory('/etc/httpd/ssl').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'create /etc/httpd/conf.d' do
    expect(chef_run).to create_directory('/etc/httpd/conf.d').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'create /var/cache/httpd' do
    expect(chef_run).to create_directory('/var/cache/httpd').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'creates /etc/httpd/conf/httpd.conf' do
    expect(chef_run).to create_template('/etc/httpd/conf/httpd.conf').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'creates /etc/httpd/conf.d/security.conf' do
    expect(chef_run).to create_template('/etc/httpd/conf.d/security.conf').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'creates /etc/httpd/conf.d/charset.conf' do
    expect(chef_run).to create_template('/etc/httpd/conf.d/charset.conf').with(
      user: 'root',
      group: 'root',
    )
  end

  it 'creates /etc/httpd/ports.conf' do
    expect(chef_run).to create_template('/etc/httpd/ports.conf').with(
      user: 'root',
      group: 'root',
    )
  end
end