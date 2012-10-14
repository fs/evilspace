# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'evilspace/version'

Gem::Specification.new do |gem|
  gem.name          = "evilspace"
  gem.version       = Evilspace::VERSION
  gem.authors       = ["nicck", "4r2r"]
  gem.email         = ["nicck.olay@gmail.com"]
  gem.description   = %q{Force trailing spaces and tabs removing from your rails application codebase.}
  gem.summary       = %q{Show HTTP 500 page with warning about evil spaces in ruby sources.}
  gem.homepage      = ""

  gem.add_development_dependency 'rack-test'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
