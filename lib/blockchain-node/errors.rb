module BlockchainNode
  module Errors
    class BadRequest < StandardError; end
    class ClientNotConfigured < StandardError; end
    class UnAuthorized < StandardError; end
    class Unknown < StandardError; end
  end
end
