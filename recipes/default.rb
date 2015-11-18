#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2015, Simone Dall Angelo
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# Download latest version of wordpress
remote_file "#{Chef::Config[:file_cache_path]}/wordpress.zip" do
  source node["wordpress"]["latest_zip_url"]
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  not_if do ::File.exists?("#{Chef::Config[:file_cache_path]}/wordpress.zip") end
end

# Create destination directory
directory node["wordpress"]["destination_path"] do
  mode 0755
  owner node["wordpress"]["ownership"]["user"]
  group node["wordpress"]["ownership"]["group"]
end

# Decompress wordpress
execute 'Extracting wordpress' do
  cwd Chef::Config[:file_cache_path]
  command "unzip #{Chef::Config[:file_cache_path]}/wordpress.zip"
  creates "#{Chef::Config[:file_cache_path]}/wordpress"
end

# Move files in the final destination
execute 'Moving file into destination' do
  command "cp -R #{Chef::Config[:file_cache_path]}/wordpress/* #{node["wordpress"]["destination_path"]}"
end

# Changing ownership
execute 'Changing ownership' do
  command "chown -R #{node["wordpress"]["ownership"]["user"]}:#{node["wordpress"]["ownership"]["group"]} #{node["wordpress"]["destination_path"]}"
end

# Setup wp-config.php
template "#{node["wordpress"]["destination_path"]}/wp-config.php" do
  source 'wp-config.php.erb'
  owner node["wordpress"]["ownership"]["user"]
  group node["wordpress"]["ownership"]["group"]
  mode 0644
end

# Remove wp-config-sample.php
file "#{node["wordpress"]["destination_path"]}/wp-config-sample.php" do
  action :delete
end
