# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-bundlewrap/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-bundlewrap"
  spec.version       = Vagrant::BundleWrap::VERSION
  spec.authors       = ["Benjamin Kendinibilir"]
  spec.email         = ["bkendinibilir@seibert-media.net"]
  spec.summary       = "Vagrant BundleWrap provisioner."
  spec.description   = "Enables Vagrant to provision machines with BundleWrap. This Plugin is formerly known as 'vagrant-blockwart'."
  spec.homepage      = "https://github.com/bkendinibilir/vagrant-bundlewrap"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "ssh-config", "~> 0.1.3"
end
