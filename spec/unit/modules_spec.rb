# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_apache::modules' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

  it 'creates auth_basic.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/auth_basic.load')
  end

  it 'runs a2enmod auth_basic' do
    expect(chef_run).to run_execute('a2enmod auth_basic')
  end

  it 'creates status.conf' do
    expect(chef_run).to create_template('/etc/httpd/mods-available/status.conf')
  end

  it 'creates status.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/status.load')
  end

  it 'runs a2enmod status' do
    expect(chef_run).to run_execute('a2enmod status')
  end

  it 'creates alias.conf' do
    expect(chef_run).to create_template('/etc/httpd/mods-available/alias.conf')
  end

  it 'creates alias.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/alias.load')
  end

  it 'runs a2enmod alias' do
    expect(chef_run).to run_execute('a2enmod alias')
  end

  it 'creates authn_file.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/authn_file.load')
  end

  it 'runs a2enmod authn_file' do
    expect(chef_run).to run_execute('a2enmod authn_file')
  end

  it 'creates authz_default.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/authz_default.load')
  end

  it 'runs a2enmod authz_default' do
    expect(chef_run).to run_execute('a2enmod authz_default')
  end

  it 'creates authz_groupfile.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/authz_groupfile.load')
  end

  it 'runs a2enmod authz_groupfile' do
    expect(chef_run).to run_execute('a2enmod authz_groupfile')
  end

  it 'creates authz_host.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/authz_host.load')
  end

  it 'runs a2enmod authz_host' do
    expect(chef_run).to run_execute('a2enmod authz_host')
  end

  it 'creates authz_user.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/authz_user.load')
  end

  it 'runs a2enmod authz_user' do
    expect(chef_run).to run_execute('a2enmod authz_user')
  end

  it 'creates autoindex.conf' do
    expect(chef_run).to create_template('/etc/httpd/mods-available/autoindex.conf')
  end

  it 'creates autoindex.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/autoindex.load')
  end

  it 'runs a2enmod autoindex' do
    expect(chef_run).to run_execute('a2enmod autoindex')
  end

  it 'creates dir.conf' do
    expect(chef_run).to create_template('/etc/httpd/mods-available/dir.conf')
  end

  it 'creates dir.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/dir.load')
  end

  it 'runs a2enmod dir' do
    expect(chef_run).to run_execute('a2enmod dir')
  end

  it 'creates env.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/env.load')
  end

  it 'runs a2enmod env' do
    expect(chef_run).to run_execute('a2enmod env')
  end

  it 'creates mime.conf' do
    expect(chef_run).to create_template('/etc/httpd/mods-available/mime.conf')
  end

  it 'creates mime.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/mime.load')
  end

  it 'runs a2enmod mime' do
    expect(chef_run).to run_execute('a2enmod mime')
  end

  it 'creates negotiation.conf' do
    expect(chef_run).to create_template('/etc/httpd/mods-available/negotiation.conf')
  end

  it 'creates negotiation.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/negotiation.load')
  end

  it 'runs a2enmod negotiation' do
    expect(chef_run).to run_execute('a2enmod negotiation')
  end

  it 'creates setenvif.conf' do
    expect(chef_run).to create_template('/etc/httpd/mods-available/setenvif.conf')
  end

  it 'creates setenvif.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/setenvif.load')
  end

  it 'runs a2enmod setenvif' do
    expect(chef_run).to run_execute('a2enmod setenvif')
  end

  it 'creates log_config.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/log_config.load')
  end

  it 'runs a2enmod log_config' do
    expect(chef_run).to run_execute('a2enmod log_config')
  end

  it 'creates logio.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/logio.load')
  end

  it 'runs a2enmod logio' do
    expect(chef_run).to run_execute('a2enmod logio')
  end

  it 'creates rewrite.load' do
    expect(chef_run).to create_file('/etc/httpd/mods-available/rewrite.load')
  end

  it 'runs a2enmod rewrite' do
    expect(chef_run).to run_execute('a2enmod rewrite')
  end
end
