# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flying_table/version'

Gem::Specification.new do |spec|
  spec.name          = "flying_table"
  spec.version       = FlyingTable::VERSION
  spec.authors       = ["Chris Moody"]
  spec.email         = ["cmoody@transcon.com"]
  spec.summary       = %q{Table and class maker primarily for testing}
  spec.homepage      = "https://github.com/transcon/flying_table"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'minitest-reporters',  '>= 1.0.1'
  spec.add_development_dependency 'sqlite3'
end
