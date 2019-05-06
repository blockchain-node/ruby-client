require_relative 'blockchain-node/client'
require_relative 'blockchain-node/configuration'
require_relative 'blockchain-node/errors'
require_relative 'blockchain-node/request'
require_relative 'blockchain-node/version'

require_relative 'blockchain-node/model'
require_relative 'blockchain-node/model/base'
require_relative 'blockchain-node/model/bitcoin'
require_relative 'blockchain-node/model/ethereum'

module BlockchainNode
  def self.configure
    yield Configuration if block_given?
  end

  def self.config
    config = {}
    Configuration::ATTRIBUTES.each do |attribute|
      config[attribute] = BlockchainNode::Configuration.send(attribute)
    end
    config
  end
end
