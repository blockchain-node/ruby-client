module BlockchainNode
  module Model
    class Base
      def initialize(client)
        @client = client
      end

      def blockchain
        raise "implement me in subclass"
      end

    end
  end
end
