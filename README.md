# puppet-confluence
Puppet module for Altassian Confluence
Created by Luke Chavers <github.com/vmadman>

This module is a copy/translation of the puppet-jira module by Bryce Johnson <github.com/brycejohnson/puppet-jira>.
While Bryce Johnson also offers a confluence module, it is older and not yet complete, so I decided to start my own
based on his Jira work.

Important Note:  I am currently working on this module and it is in no way ready for release, use with EXTREME caution.

## Introduction
puppet-confluence is a module for Atlassian's Enterprise Wiki: Confluence.

## Requirements
* Java - Tested with Open JDK 1.6:
* Puppet-Deploy - https://github.com/mkrakowitzer/puppet-deploy.git

### Puppet
Tested on Puppet 3.x+

### Operating Systems
* Linux:  CentOS 6.4

Should work on other distributions, but it has not been tested.

### Databases
* MySQL (tested)
* Postgres (not tested)

### Before you begin
Backup your database.  This module expects you to have your database
preconfigured and ready for Confluence.

### Installation

This puppet module will automatically download the confluence zip from Atlassian
and extract it into /opt/atlassian/confluence/confluence-$version

An example on how to use this module:

    // Radically incomplete
    class { 'confluence':
      version     => '5.3.4',
      installdir  => '/opt/atlassian/confluence',
      homedir     => '/opt/atlassian/confluence/confluence-home',
      user        => 'confluence',
      group       => 'confluence',
      dbpassword  => 'secret',
      dbserver    => 'localhost',
      javahome    => '/opt/java/jdk1.7.0_21/',
      downloadURL  => 'http://myserver/pub/development-tools/atlassian/',
    }

If you would prefer to use Hiera then see confluence.yaml file for an example.

### Fixes and Future Work
Please feel free to raise any issues here for fixes.  I'm happy to fix them
up.  Also feel free to make a pull request for anything so I can hopefully
get it in.
