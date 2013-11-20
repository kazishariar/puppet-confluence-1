# == Class: confluence::config
#
# This module will install Atlassian Confluence.
#
# === Parameters: none
# === Examples
#
# This class should not be called directly.  Use the base 'confluence' class instead.
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
class confluence::config {

  # File defaults
  File {
    owner => $confluence::user,
    group => $confluence::group,
    mode => "0755"
  }

  # Useful paths
  $path_lib = "${confluence::path_install}/lib"
  $path_mcj = "${path_lib}/mysql-connector-java.jar"

  anchor{ 'confluence::config::begin': } ->

  file { "${path_mcj}":
    ensure  => 'link',
    mode => "0755",
    target  => "/usr/share/java/mysql-connector-java.jar"
  } ->

  file { "${confluence::path_install}/bin/user.sh":
    content => template('confluence/user.sh.erb'),
    mode    => '0755',
    require => [ Class['confluence::install'], File[$confluence::path_link] ],
  } ->

  file { "${confluence::path_install}/bin/setenv.sh":
    content => template('confluence/setenv.sh.erb'),
    mode    => '0755',
    require => [ Class['confluence::install'], File[$confluence::path_link] ],
  } ->

  file { "${confluence::path_install}/confluence/WEB-INF/classes/confluence-init.properties":
    content => template("confluence/confluence-init.properties.erb"),
    mode    => '0644',
    require => [ Class['confluence::install'],File[$confluence::path_link] ],
    #notify  => Class['confluence::service'],
  } ->

  anchor{ 'confluence::config::end': }

}
