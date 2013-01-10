# -*- encoding: utf-8 -*-
require File.expand_path('../lib/yaml_convertor/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nour"]
  gem.email         = ["nour.fwh@gmail.com"]
  gem.description   = %q{yaml_convertor converts YAML hash structure to simple key:value }
  gem.summary       = %q{YAML to simple key:value hash}
  gem.homepage      = "https://rubygems.org/gems/yaml_convertor"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "yaml_convertor"
  gem.require_paths = ["lib"]
  gem.version       = YamlConvertor::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'test-unit'
  gem.add_runtime_dependency 'psych', '1.3.4'
end
