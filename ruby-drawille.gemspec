# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-drawille/version'

Gem::Specification.new do |gem|
  gem.name          = "drawille"
  gem.version       = Drawille::VERSION
  gem.authors       = ["Marcin Skirzynski"]
  gem.email         = ["marcin.skirzynski@gmail.com"]
  gem.description   = %q{Drawing in terminal with Unicode Braille characters.}
  gem.summary       = %q{Drawing in terminal with Unicode Braille characters.}
  gem.homepage      = "https://github.com/maerch/ruby-drawille"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end
