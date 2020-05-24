# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'templar/version'

Gem::Specification.new do |spec|
  spec.name          = 'templar'
  spec.version       = Templar::VERSION
  spec.authors       = ['Aaron Massey']
  spec.email         = ['akmassey@sixlines.org']
  spec.description   = 'A templating engine for creating new LaTeX projects.'
  spec.summary       = 'A templating engine for creating new LaTeX projects.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'safe_yaml'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
