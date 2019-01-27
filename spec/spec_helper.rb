require 'pry'
require 'timecop'
require 'webmock/rspec'

require File.expand_path('../lib/blockchain-node', File.dirname(__FILE__))

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each { |f| require f }
