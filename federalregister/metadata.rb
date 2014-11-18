name             'federalregister'
maintainer       'Critical Juncture, LLC'
maintainer_email 'info@criticaljuncture.org'
license          'Apache 2.0'
description      'Installs/Configures federalregister'
long_description 'Installs/Configures federalregister'
version          '0.1.0'

depends "s3cmd_federalregister", '~> 0.1.0'
depends 'hostsfile', '~> 2.4.5'

supports "ubuntu"
