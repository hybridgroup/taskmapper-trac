# taskmapper-trac

This is a provider for [taskmapper](http://ticketrb.com). It provides interoperability with [Trac](http://trac.edgewall.org) and it's issue tracking system through the taskmapper gem.

# Usage and Examples

First we have to instantiate a new taskmapper instance, your trac installation should have api access enable:
    trac = taskmapper.new(:trac, {:username=> 'foo', :password => "bar", :url => "http://tracserver/username/project/trac"})

If you do not pass in the url, username and password, you won't get any information.

## Finding Projects(Repositories)

Right now Trac doesn't support project handling, that's why you will use a project holder which consist of your username and url for the Trac instance.

## Finding Tickets(Issues)

    tickets = project.tickets # All tickets
    ticket = project.tickets(:status => '!closed') # All non closed tickets, you can specified any type of attributes field based on Trac scheme. ex. :component => 'Web'

## Open Tickets

	ticket = project.ticket!({:summary => "New ticket", :description=> "Body for the very new ticket"}, attributes) # summary and description are mandatory fields the attributes hash will contain all the optional info that you need for your ticket, have to use the fields provided by Trac api.

## Finding comments

        comments = project.tickets.first.comments # All the tickets facility for searchs are available for comments as well


## Requirements

* rubygems (obviously)
* taskmapper gem (latest version preferred)
* jeweler gem (only if you want to repackage and develop)
* trac4r

The taskmapper gem should automatically be installed during the installation of this gem if it is not already installed.

## Other Notes

Since this and the taskmapper gem is still primarily a work-in-progress, minor changes may be incompatible with previous versions. Please be careful about using and updating this gem in production.

If you see or find any issues, feel free to open up an issue report.


## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so we don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself so we can ignore when I pull)
* Send us a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 The Hybrid Group. See LICENSE for details.


