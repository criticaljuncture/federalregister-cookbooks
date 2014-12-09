default['iodocs']['path']           = "/var/www/apps/iodocs"
default['iodocs']['repo_url']       = "git://github.com/mashery/iodocs.git"
default['iodocs']['repo_ref']       = "master"

default['iodocs']['address']        = "0.0.0.0"
default['iodocs']['port']           = 3000

default['iodocs']['title']          = "I/O Docs - http://github.com/mashery/iodocs"
default['iodocs']['debug']          = false
default['iodocs']['session_secret'] = "12345"
default['iodocs']['user']           = "iodocs"
default['iodocs']['group']          = "iodocs"

default['iodocs']['redis']['database']  = 0
default['iodocs']['redis']['host']      = "0.0.0.0"
default['iodocs']['redis']['port']      = "6379"
default['iodocs']['redis']['password']  = ""
