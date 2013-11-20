# == Class: confluence::install
#
# This module will install Atlassian Confluence.
# This module requires mkrakowitzer-deploy <github.com/mkrakowitzer/puppet-deploy>
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
class confluence::install {

  require confluence

  deploy::file { "atlassian-${confluence::product}-${confluence::version}.${confluence::format}":
    target  => "${confluence::installdir}/atlassian-${confluence::product}-${confluence::version}-standalone",
    url     => $confluence::downloadURL,
    strip   => true,
    notify  => Exec["chown_${confluence::webappdir}"],
  } ->

  user { $confluence::user:
    comment          => 'Confluence daemon account',
    shell            => '/bin/true',
    home             => $confluence::homedir,
    password         => '*',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
  } ->

  file { $confluence::homedir:
    ensure  => 'directory',
    owner   => $confluence::user,
    group   => $confluence::group,
    recurse => true,
  } ->

  exec { "chown_${confluence::webappdir}":
    command     => "/bin/chown -R ${confluence::user}:${confluence::group} ${confluence::webappdir}",
    refreshonly => true,
    subscribe   => User[$confluence::user]
  } ->

  file { '/etc/init.d/confluence':
    content => template('confluence/etc/rc.d/init.d/confluence.erb'),
    mode    => '0755',
  }

}
