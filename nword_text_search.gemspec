# coding: utf-8
# rubocop:disable Style/SingleSpaceBeforeFirstArg

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nword_text_search/version'

Gem::Specification.new do |spec|
  spec.name          = 'nword_text_search'
  spec.version       = NwordTextSearch::VERSION
  spec.authors       = ['Levon Becker']
  spec.email         = ['levon.devops@bonusbits.com']
  spec.summary       = 'Programming Exercise'
  spec.description   = 'Search a directory of text files for two words separated by n words.'
  spec.homepage      = 'https://github.com/LevonBecker/nword_text_search'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_runtime_dependency 'highline', '~> 1.7'
end
