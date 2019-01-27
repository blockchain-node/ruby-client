module BlockchainNode
  class Client

    @@_auth_token
    AuthToken = Struct.new(:token, :expires_at)

    attr_reader :node_id
    attr_accessor :configuration

    def initialize(node_id)
      @node_id = node_id
      # allow a different configuration per client instance
      @configuration = BlockchainNode::Configuration.new
    end

    # convenience method to get nodes index
    def nodes
      request.get(path: node_index_path, auth_token: auth_token)
    end

    def auth_token
      @@_auth_token ||= get_new_auth_token
      @@_auth_token = get_new_auth_token if auth_token_expired?
      @@_auth_token.token
    end

    private

    # catch all other method calls and assume its the RPC method call
    def method_missing(method, *args, &block)
      data = { method: method, parameters: args }
      request.post(path: nodes_path, data: data, auth_token: auth_token)
    end

    def auth_token_expired?
      @@_auth_token.nil? || @@_auth_token.expires_at < Time.now.utc - 30
    end

    def get_new_auth_token
      data = {
        grant_type: "client_credentials",
        client_id: configuration.client_id,
        client_secret: configuration.client_secret,
      }
      response = request.post(path: oauth_token_path, data: data)
      token = response["access_token"]
      expires_at = Time.at(response["created_at"] + response["expires_in"]).utc
      AuthToken.new(token, expires_at)
    end

    def request
      @request ||= BlockchainNode::Request.new(configuration.request_options)
    end

    def oauth_token_path
      "/oauth/token"
    end

    def node_index_path
      "/api/nodes"
    end

    def nodes_path
      "/api/nodes/#{@node_id}"
    end

  end
end
