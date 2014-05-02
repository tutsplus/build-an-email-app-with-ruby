# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qrier/version'

Gem::Specification.new do |spec|
  spec.name          = "qrier"
  spec.version       = Qrier::VERSION
  spec.authors       = ["José Mota"]
  spec.email         = ["jose@josemota.net"]
  spec.summary       = %q{Fetch and send email.}
  #spec.description   = %q{TODO}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
