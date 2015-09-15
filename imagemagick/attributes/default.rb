default['imagemagick']['version']         = "6.9.2-1"
default['imagemagick']['package_name']    = "ImageMagick-#{node['imagemagick']['version']}.tar.gz"
default['imagemagick']['download_path']   = "/tmp/#{node['imagemagick']['package_name']}"
default['imagemagick']['download_url']    = "http://www.imagemagick.org/download/#{node['imagemagick']['package_name']}"
