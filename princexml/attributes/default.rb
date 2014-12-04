default['princexml']['version'] = '8.1 rev 5'
default['princexml']['package_name'] = "prince_#{node['princexml']['version'].gsub(" rev ", "-")}_ubuntu12.04_amd64.deb"
default['princexml']['download_path'] = "/tmp/#{node['princexml']['package_name']}"
default['princexml']['download_url'] = "http://www.princexml.com/download/#{node['princexml']['package_name']}"
default['princexml']['fonts'] = {}
default['princexml']['license_location'] = "/usr/lib/prince/license/license.dat"
