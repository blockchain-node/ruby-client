# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "blockchain-node/version"

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = "blockchain-node"
  s.version      = BlockchainNode::VERSION
  s.summary      = "BlockchainNode Ruby Client"
  s.description  = "Client SDK for accessing BlockchainNode API."
  s.licenses     = [ "MIT" ]
  s.authors      = ["Matt Pestritto"]
  s.email        = ["matt@blockchainnode.io"]
  s.homepage     = "https://blockchainnode.io"

  s.files         = Dir["{lib,spec}/**/*", "[A-Z]*"] - ["Gemfile.lock"]
  s.require_paths = ["lib"]

  s.add_development_dependency("pry", "~> 0.12")
  s.add_development_dependency("rake", "~> 0.9")
  s.add_development_dependency("rspec", "~> 3")
  s.add_development_dependency("timecop", "~> 0.9")
  s.add_development_dependency("webmock", "~> 3")
end
