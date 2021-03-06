# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_fec_api/version'

Gem::Specification.new do |spec|
  spec.name          = "open_fec_api"
  spec.version       = OpenFecApi::VERSION
  spec.authors       = ["MJ Rossetti (@s2t2)"]
  spec.email         = ["s2t2mail@gmail.com"]
  spec.summary       = %q{A ruby interface to the Open Federal Elections Commission (FEC) API.}
  spec.description   = %q{A ruby interface to the Open Federal Elections Commission (FEC) API. Returns data about election candidates and committees. Includes options to customize API requests.}
  spec.homepage      = "https://github.com/data-creative/open-fec-api-ruby/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "yard"
  spec.add_dependency "httparty", "~> 0.13"
end
