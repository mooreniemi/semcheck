# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'semcheck/version'

Gem::Specification.new do |spec|
  spec.name          = "semcheck"
  spec.version       = Semcheck::VERSION
  spec.authors       = ["Alex Moore-Niemi"]
  spec.email         = ["amooreniemi@zipcar.com"]

  spec.summary       = %q{Command line tool to reconcile your domain language against existing schemas.}
  spec.description   = %q{Think of Semcheck as your helpful automated reference librarian for schemas.}
  spec.homepage      = "https://github.com/mooreniemi/semcheck"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # for local thesaurus check
  spec.add_dependency "bronto-gem"
  # for api thesaurus check
  spec.add_dependency "dinosaurus"
  spec.add_dependency "google-search"
  spec.add_dependency "crack"
  spec.add_dependency "rest-client"
  spec.add_dependency "mechanize"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
