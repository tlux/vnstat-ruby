# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vnstat/version'

Gem::Specification.new do |spec|
  spec.name = 'vnstat-ruby'
  spec.version = Vnstat::VERSION
  spec.authors = ['Tobias Casper']
  spec.email = ['tobias.casper@gmail.com']

  spec.summary = 'A library to track your network traffic using vnstat.'
  spec.description =
    'Utilizes the the vnstat CLI to track your network traffic.'
  spec.homepage = 'https://github.com/tlux/vnstat-ruby'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3.0'

  spec.add_dependency 'nokogiri', '~> 1.8.5'
  spec.add_dependency 'systemcall', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.68.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.1.0'
  spec.add_development_dependency 'yard', '~> 0.9.20'
end
