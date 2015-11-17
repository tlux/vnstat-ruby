# vnstat-ruby

Vnstat is a tool that tracks the traffic on your network interfaces.
This tiny library dependends on the `vnstat` command line utility to provide
network traffic information through an easy-to-use API.


### Getting Started

#### Prerequisites

First, make sure
you have vnstat installed by running `which vnstat`.

Once everything is set up fine, you are ready to install the vnstat-ruby gem:

```bash
gem install vnstat-ruby
```

Or, add the following line to your Gemfile and run the `bundle install` command:

```ruby
gem 'vnstat-ruby'
```

#### Configuration

By default, vnstat-ruby tries to automatically determine the location of your
vnstat executable. If you need to change this path for some reason, you can
override the default:

```ruby
Vnstat.configure do |config|
  config.executable_path = '/usr/bin/vnstat'
end
```

### Usage

TODO


### Contributing to vnstat-ruby

* Check out the latest master to make sure the feature hasn't been implemented
  or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it
  and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to
  have your own version, or is otherwise necessary, that is fine, but please
  isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2015 Tobias Casper. See LICENSE.txt for
further details.
