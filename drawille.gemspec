# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'drawille/version'

Gem::Specification.new do |gem|
  gem.name          = "drawille"
  gem.version       = Drawille::VERSION
  gem.authors       = ["Marcin Skirzynski"]
  gem.description   = %q{Drawing in terminal.}
  gem.summary       = %q{Drawing in terminal with Unicode Braille characters.}
  gem.license       = "MIT"
  gem.homepage      = "https://github.com/maerch/ruby-drawille"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'curses'
  gem.add_development_dependency 'rspec'
end
