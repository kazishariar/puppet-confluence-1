# == Class: confluence::install
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
class confluence::install {

  # http://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-5.3.4.zip

  anchor {'confluence::install::begin': } ->

  file { $confluence::path_atlassian:
    ensure  => 'directory',
    mode => "0755",
    recurse => true,
  } ->

  file { $confluence::path_confluence:
    ensure  => 'directory',
    mode => "0755",
    recurse => true,
  } ->

  file { $confluence::path_home:
    ensure  => 'directory',
    mode => "0755",
    recurse => true,
  } ->

  user { $confluence::user:
    comment          => 'Confluence daemon account',
    shell            => '/bin/true',
    home             => $confluence::path_home,
    password         => '*',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
    require          => File[$confluence::path_home],
  } ->

  wget::fetch { "download_confluence":
    source      => "${confluence::downloadURL}/atlassian-confluence-${confluence::version}.zip",
    destination => "${confluence::path_confluence}/atlassian-confluence-${confluence::version}.zip",
  } ->

  exec { "extract_confluence":
    cwd         => $confluence::path_confluence,
    command     => "/usr/bin/unzip atlassian-confluence-${confluence::version}.zip",
    refreshonly => true,
    subscribe   => Wget::Fetch["download_confluence"],
  } ->

  file { $confluence::path_link:
    ensure  => 'link',
    mode => "0755",
    target  => $confluence::path_install
  } ->

  exec { "chown_${confluence::path_confluence}":
    command     => "/bin/chown -R ${confluence::user}:${confluence::group} ${confluence::path_confluence}",
  } ->

  anchor {'confluence::install::end': }

}
