# Databag for credentials
default['s3cmd']['credentials_data_bag_name'] = 'credentials'


# or S3 credentials if not using databags
# be sure to set the credentials bag item to ''
default['s3cmd']['aws_access_key_id'] = ""
default['s3cmd']['aws_secret_access_key'] = ""

# Other setting you may want to configure
# true/false values are strings 'True' or 'False'
default['s3cmd']['use_https'] = 'True'
default['s3cmd']['gpg_passphrase'] = ''
