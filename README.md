# vnstat-ruby

[![Code Climate](https://codeclimate.com/github/tlux/vnstat-ruby/badges/gpa.svg)](https://codeclimate.com/github/tlux/vnstat-ruby) [![Test Coverage](https://codeclimate.com/github/tlux/vnstat-ruby/badges/coverage.svg)](https://codeclimate.com/github/tlux/vnstat-ruby/coverage) [![Build Status](https://travis-ci.org/tlux/vnstat-ruby.svg?branch=master)](https://travis-ci.org/tlux/vnstat-ruby)

Vnstat is a tool that tracks the traffic on your network interfaces.
This tiny library dependends on the `vnstat` command line utility to provide
network traffic information through an easy-to-use API.


### Prerequisites

You need one of the following Ruby versions installed to run the gem:

* Ruby >= 1.9.3
* JRuby
* Rubinius >= 2

Also make sure you have the vnstat CLI installed by running `which vnstat`.

If the executable was not found, you are able to obtain the vnstat package
via aptitude (or a similar package manager):

```bash
apt-get install vnstat
```


### Getting Started

#### Setup

Once the dependent package is installed, you are ready to install the
vnstat-ruby gem.

```bash
gem install vnstat-ruby
```

Or, add the following line to the Gemfile of your project and run the
`bundle install` command:

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

#### Network Interfaces

To retrieve a list of all known network interfaces:

```ruby
Vnstat.interfaces # => #<Vnstat::InterfaceCollection ...>
Vnstat.interfaces.ids # => ['eth01', 'eth02']
```

To only retrieve traffic stats for a single interface:

```ruby
Vnstat.interfaces.first # => #<Vnstat::Interface id: "eth01">
```

If you know the name of a network interface, you can also retrieve the
stats of that particular one:

```ruby
Vnstat['eth01'] # => #<Vnstat::Interface id: "eth01">
```

#### Monthly Traffic

TBD

#### Daily Traffic

TBD

#### Hourly Traffic

TBD

#### Tops

TBD

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
