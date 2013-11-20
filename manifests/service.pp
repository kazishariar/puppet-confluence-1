# == Class: confluence::service
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
class confluence::service {

  if( $confluence::manage_service ) {

    file { "/etc/rc.d/init.d/confluence":
      content => template("confluence/confluence.initd.erb"),
      mode    => '0755',
      require => [ Class['confluence::install'], Class['confluence::config'] ],
      notify  => Service[$confluence::service_name],
    }

    service { $confluence::service_name:
      ensure    => 'running',
      provider  => base,
      start     => '/etc/init.d/confluence start',
      restart   => '/etc/init.d/confluence restart',
      stop      => '/etc/init.d/confluence stop',
      status    => '/etc/init.d/confluence status',
      require   => Class['confluence::config'],
    }
  }

}
