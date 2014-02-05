#
# Cookbook Name:: rackspace_apache
# Definition:: web_app
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

define :web_app, :template => 'web_app.conf.erb', :enable => true do

  application_name = params[:name]

  include_recipe 'rackspace_apache::default'
  apache_module 'rewrite'
  apache_module 'headers'

  template "#{node['rackspace_apache']['dir']}/sites-available/#{application_name}.conf" do
    source   params[:template]
    owner    'root'
    group    node['rackspace_apache']['root_group']
    mode     '0644'
    cookbook params[:cookbook] if params[:cookbook]
    variables(
      :application_name => application_name,
      :params           => params
    )
    if ::File.exists?("#{node['rackspace_apache']['dir']}/sites-enabled/#{application_name}.conf")
      notifies :reload, 'service[apache2]'
    end
  end

  site_enabled = params[:enable]
  apache_site "#{params[:name]}.conf" do
    enable site_enabled
  end
end
