# -*- encoding: utf-8 -*-
require File.expand_path('../lib/conditional_delegate/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Roel van Dijk"]
  gem.email         = ["roel@rustradio.org"]
  gem.description   = %q{ConditionalDelegate allows delegates to be conditional.}
  gem.summary       = %q{ConditionalDelegate allows delegates to be conditional.}
  gem.homepage      = "http://github.com/rdvdijk/conditional_delegate"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "conditional_delegate"
  gem.require_paths = ["lib"]
  gem.version       = ConditionalDelegate::VERSION

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
