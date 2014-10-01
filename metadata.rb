name             'pxe'
maintainer       'Denis Chekirda'
maintainer_email 'dchekirda@gmail.com'
license          'All rights reserved'
description      'Installs local bootstraping and installation system via PXE booting.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.5'

depends "apt"
depends "yum"
depends "tftp"
depends "apache2"

%w{rhel centos debian ubuntu}.each do |os|
  supports os
end
