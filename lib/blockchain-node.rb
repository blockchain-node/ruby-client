module BlockchainNode
  autoload :Client, 'blockchain-node/client'
  autoload :Configuration, 'blockchain-node/configuration'
  autoload :Errors, 'blockchain-node/errors'
  autoload :Request,'blockchain-node/request'
  autoload :VERSION,'blockchain-node/version'

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
