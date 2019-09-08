# vnstat-ruby

[![Build Status](https://travis-ci.org/tlux/vnstat-ruby.svg?branch=master)](https://travis-ci.org/tlux/vnstat-ruby)
[![Coverage Status](https://coveralls.io/repos/github/tlux/vnstat-ruby/badge.svg?branch=master)](https://coveralls.io/github/tlux/vnstat-ruby?branch=master)
[![Gem Version](https://badge.fury.io/rb/vnstat-ruby.svg)](https://badge.fury.io/rb/vnstat-ruby)

Vnstat is a tool that tracks the traffic on your network interfaces.
This tiny library is intended to provide network traffic information
through an easy-to-use API.

It depends on the
[vnstat command line utility](http://humdi.net/vnstat/) which is
maintained by Teemu Toivola.

### Prerequisites

* Ruby 2.3.0 or greater
* Make sure you have `vnstat` CLI installed by running `which vnstat`.

On Ubuntu you can get the vnstat package via `apt-get install vnstat`.

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
Vnstat.config.executable_path = '/usr/bin/vnstat'
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

#### Traffic Information

##### Total

```ruby
interface = Vnstat['eth01']
```

```ruby
interface.total # => #<Vnstat::Result ...>
interface.total.bytes_received # => 1024000
interface.total.bytes_sent # => 2048000
interface.total.bytes_transmitted # => 3072000
```

##### By Month

```ruby
interface.months # => #<Vnstat::Traffic::Monthly ...>
```

```ruby
interface.months.first
interface.months[2015, 9]
# => #<Vnstat::Result::Month year: 2015, month: 9, ...>
```

```ruby
interface.months[2015, 10].bytes_received # => 3072000
```

##### By Day

```ruby
interface.days # => #<Vnstat::Traffic::Daily ...>
```

```ruby
interface.days.first
interface.days[Date.new(2015, 11, 23)]
interface.days[2015, 11, 23]
# => #<Vnstat::Result::Day date: #<Date: 2015-11-23>, ...>
```

```ruby
interface.days[2015, 11, 23].bytes_received # => 2048000
```

##### By Hour

```ruby
interface.hours # => #<Vnstat::Traffic::Hourly ...>
```

```ruby
interface.hours.first
interface.hours[Date.new(2015, 9, 22), 10]
interface.hours[2015, 9, 22, 10]
# => #<Vnstat::Result::Hour date: #<Date: 2015-11-23>, hour: 10>
```

```ruby
interface.hours[2015, 9, 22, 10].bytes_received # => 2048000
```

##### Tops

```ruby
interface.tops #=> #<Vnstat::Traffic::Tops ...>
interface.tops.count #=> 10
interface.tops.each do |top|
  # ...
end
```

```ruby
interface.tops.first
interface.tops[2]
# => #<Vnstat::Result::Minute time: 2015-11-05 09:03:42 +0000>
```

```ruby
interface.tops[1].bytes_received # => 1024000
```

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

Copyright (c) 2015-2017 Tobias Casper. See LICENSE.txt for further details.
