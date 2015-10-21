# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'vnstat-ruby'
  gem.homepage = 'http://github.com/tlux/vnstat-ruby'
  gem.license = 'MIT'
  gem.summary = 'A Ruby wrapper for vnstat'
  gem.description = gem.summary
  gem.email = 'tobias.casper@gmail.com'
  gem.authors = ['Tobias Casper']
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

task default: :test
