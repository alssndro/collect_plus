# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'collect_plus/version'

Gem::Specification.new do |spec|
  spec.name          = "collect_plus"
  spec.version       = CollectPlus::VERSION
  spec.authors       = ["Alessandro"]
  spec.email         = ["hello@alessndro.co.uk"]
  spec.summary       = %q{Track parcels sent via CollectPlus}
  spec.description   = %q{Track parcels sent via CollectPlus}
  spec.homepage      = "https://github.com/alssndro/collect_plus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "nokogiri"
end
