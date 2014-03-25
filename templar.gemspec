# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'templar/version'

Gem::Specification.new do |spec|
  spec.name          = "templar"
  spec.version       = Templar::VERSION
  spec.authors       = ["Aaron Massey"]
  spec.email         = ["akmassey@sixlines.org"]
  spec.description   = %q{A templating engine for creating new LaTeX projects.}
  spec.summary       = %q{A templating engine for creating new LaTeX projects.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "safe_yaml"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
