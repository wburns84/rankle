# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rankle/version'

Gem::Specification.new do |spec|
  spec.name          = "rankle"
  spec.version       = Rankle::VERSION
  spec.authors       = ["Wil"]
  spec.email         = ["rankle@william-burns.com"]
  spec.summary       = %q{Rankle provides multi-resource ranking.}
  spec.description   = %q{Rankle provides multi-resource ranking.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "factory_girl_rails"
end
