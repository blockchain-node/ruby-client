module BlockchainNode
  class Configuration
    ATTRIBUTES = [:client_id, :client_secret, :request_options]

    # class attributes
    class << self
      ATTRIBUTES.each do |attr|
        attr_accessor attr
      end
    end

    # instance attributes
    ATTRIBUTES.each do |attr|
      attr_accessor attr
    end

    def initialize
      @client_id = self.class.client_id
      @client_secret = self.class.client_secret
      @request_options = self.class.request_options || {}
    end

  end
end
