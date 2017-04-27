# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: vnstat-ruby 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "vnstat-ruby".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tobias Casper".freeze]
  s.date = "2017-04-27"
  s.description = "Uses the the vnstat CLI to track your network traffic.".freeze
  s.email = "tobias.casper@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".codeclimate.yml",
    ".document",
    ".rspec",
    ".rubocop.yml",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/vnstat-ruby.rb",
    "lib/vnstat.rb",
    "lib/vnstat/configuration.rb",
    "lib/vnstat/document.rb",
    "lib/vnstat/error.rb",
    "lib/vnstat/errors/executable_not_found.rb",
    "lib/vnstat/errors/unknown_interface.rb",
    "lib/vnstat/interface.rb",
    "lib/vnstat/interface_collection.rb",
    "lib/vnstat/parser.rb",
    "lib/vnstat/result.rb",
    "lib/vnstat/result/date_delegation.rb",
    "lib/vnstat/result/day.rb",
    "lib/vnstat/result/hour.rb",
    "lib/vnstat/result/minute.rb",
    "lib/vnstat/result/month.rb",
    "lib/vnstat/result/time_comparable.rb",
    "lib/vnstat/system_call.rb",
    "lib/vnstat/traffic.rb",
    "lib/vnstat/traffic/base.rb",
    "lib/vnstat/traffic/daily.rb",
    "lib/vnstat/traffic/hourly.rb",
    "lib/vnstat/traffic/monthly.rb",
    "lib/vnstat/traffic/tops.rb",
    "lib/vnstat/utils.rb",
    "spec/lib/vnstat/configuration_spec.rb",
    "spec/lib/vnstat/document_spec.rb",
    "spec/lib/vnstat/errors/executable_not_found_spec.rb",
    "spec/lib/vnstat/errors/unknown_interface_spec.rb",
    "spec/lib/vnstat/interface_collection_spec.rb",
    "spec/lib/vnstat/interface_spec.rb",
    "spec/lib/vnstat/result/day_spec.rb",
    "spec/lib/vnstat/result/hour_spec.rb",
    "spec/lib/vnstat/result/minute_spec.rb",
    "spec/lib/vnstat/result/month_spec.rb",
    "spec/lib/vnstat/result_spec.rb",
    "spec/lib/vnstat/system_call_spec.rb",
    "spec/lib/vnstat/traffic/daily_spec.rb",
    "spec/lib/vnstat/traffic/hourly_spec.rb",
    "spec/lib/vnstat/traffic/monthly_spec.rb",
    "spec/lib/vnstat/traffic/tops_spec.rb",
    "spec/lib/vnstat/utils_spec.rb",
    "spec/lib/vnstat_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/shared_examples/shared_examples_for_date_delegation.rb",
    "spec/support/shared_examples/shared_examples_for_traffic_collection.rb",
    "vnstat-ruby.gemspec"
  ]
  s.homepage = "http://github.com/tlux/vnstat-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "A Ruby wrapper for vnstat.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0"])
      s.add_development_dependency(%q<jeweler>.freeze, [">= 2.0.1", "~> 2.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0"])
    else
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.6"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0"])
      s.add_dependency(%q<jeweler>.freeze, [">= 2.0.1", "~> 2.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, ["~> 0"])
    end
  else
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.6"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 2.0.1", "~> 2.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0"])
  end
end

