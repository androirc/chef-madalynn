name             'madalynn'
maintainer       'Madalynn'
maintainer_email 'blinkseb@madalynn.eu'
license          'All rights reserved'
description      'Installs/Configures madalynn'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

depends 'user'
depends 'sudo'
depends 'chef-vault'
depends 'unattended-upgrades'
depends 'hostsfile'
