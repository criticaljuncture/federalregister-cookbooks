name             'federalregister'
maintainer       'Critical Juncture, LLC'
maintainer_email 'info@criticaljuncture.org'
license          'Apache 2.0'
description      'Installs/Configures federalregister'
long_description 'Installs/Configures federalregister'
version          '0.1.2'

#log rotation
depends "s3cmd_federalregister", '~> 0.1.0'
# etc hosts
depends 'hostsfile', '~> 2.4.5'
# aws ebs
depends 'aws', '~> 2.5.0'

supports "ubuntu"
