# == Class: confluence
#
# This module will install Atlassian Confluence.
#
# This module requires mkrakowitzer-deploy
#
# === Parameters
#
# todo
#
# === Examples
#
# todo
#
# === Authors
#
# Luke Chavers <github.com/vmadman>
# Based on the puppet-jira module by Bryce Johnson <github.com/brycejohnson/puppet-jira>
#
# === Copyright & License
#
# See the LICENSE file for license information.
#
class confluence (

  # Jira Settings
  $version      = '5.3.4',
  $product      = 'confluence',
  $format       = 'tar.gz',
  $installdir   = '/opt/atlassian/confluence',
  $homedir      = '/opt/atlassian/confluence/confluence-home',
  $user         = 'confluence',
  $group        = 'confluence',

  # Database Settings
  $db           = 'mysql',
  $dbuser       = 'confluence',
  $dbpassword   = 'secret',
  $dbserver     = 'localhost',
  $dbname       = 'confluence',
  $dbport       = '3306',
  #$dbdriver     = 'org.postgresql.Driver',
  #$dbtype       = 'postgres72',
  #$poolsize     = '15',

  # JVM Settings
  $javahome,
  $jvm_xmx      = '1024m',
  $jvm_optional = '-XX:-HeapDumpOnOutOfMemoryError',

  # Misc Settings
  $downloadURL  = 'http://www.atlassian.com/software/confluence/downloads/binary/',

) {

  #$webappdir    = "${installdir}/atlassian-${product}-${version}-standalone"
  #$dburl        = "jdbc:${db}://${dbserver}:${dbport}/${dbname}"

  include confluence::install
  #include jira::config
  #include jira::service

}
