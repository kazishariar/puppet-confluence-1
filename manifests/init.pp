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

  # Confluence Settings
  $version      = '5.3.4',
  $product      = 'confluence',
  $format       = 'zip',
  $installpath  = '/opt',
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
  $javahome     = "/usr",
  $jvm_xmx      = '1024m',
  $jvm_optional = '-XX:-HeapDumpOnOutOfMemoryError',

  # Misc Settings
  $downloadURL  = 'http://www.atlassian.com/software/confluence/downloads/binary',

  # Service Config
  $manage_service = true,
  $service_name   = "confluence"

) {

  # Set us up some composite variables
  $path_atlassian   = "${installpath}/atlassian"
  $path_confluence  = "${path_atlassian}/confluence"
  $path_install     = "${path_confluence}/atlassian-confluence-${version}"
  $path_home        = "${path_confluence}/confluence-home"
  $path_link        = "${path_confluence}/confluence-current"

  anchor{ 'confluence::begin': } ->

  class{'confluence::install': } ->
  class{'confluence::config': } ->
  class{'confluence::service': } ->

  anchor{ 'confluence::end': }

  #$webappdir    = "${installdir}/atlassian-${product}-${version}-standalone"
  #$dburl        = "jdbc:${db}://${dbserver}:${dbport}/${dbname}"

  #include confluence::install
  #include jira::config
  #include jira::service

}
