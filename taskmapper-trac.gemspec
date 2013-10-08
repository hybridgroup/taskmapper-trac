# -*- encoding: utf-8 -*-
require File.expand_path '../lib/provider/version', __FILE__

Gem::Specification.new do |spec|
  spec.name          = "taskmapper-trac"
  spec.version       = TaskMapper::Provider::Trac::VERSION
  spec.authors       = ["www.hybridgroup.com"]
  spec.email         = ["info@hybridgroup.com"]
  spec.description   = %q{A TaskMapper provider for interfacing with Trac.}
  spec.summary       = %q{A TaskMapper provider for interfacing with Trac.}
  spec.homepage      = "http://ticketrb.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "taskmapper", "~> 1.0"
  spec.add_dependency "nokogiri", "~> 1.6.0"
  spec.add_dependency "trac4r", "~> 1.2.4"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "fakeweb", "~> 1.3.0"
end
