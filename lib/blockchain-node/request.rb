require 'json'
require 'net/http'

module BlockchainNode
  class Request

    DEFAULT_BASE_URL = "https://api.blockchainnode.io"

    def initialize(options)
      @host = options[:host] || DEFAULT_BASE_URL
      @read_timeout = options[:read_timeout] || 45
      @open_timeout = options[:open_timeout] || 3
    end

    def get(path:, auth_token:)
      uri = URI(@host + path)

      request = Net::HTTP::Get.new(uri)
      request['Content-Type'] = "application/json"
      request['Authorization'] = "Bearer #{auth_token}" if auth_token

      process_request(uri, request)
    end

    def post(path:, data: {}, auth_token: nil)
      uri = URI(@host + path)

      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = "application/json"
      request['Authorization'] = "Bearer #{auth_token}" if auth_token
      request.body = data.to_json

      process_request(uri, request)
    end

    private

    def process_request(uri, request)
      response = Net::HTTP.start(uri.hostname, uri.port,
                                 use_ssl: uri.scheme == 'https',
                                 read_timeout: @read_timeout,
                                 open_timeout: @open_timeout
      ) do |http|
        http.request(request)
      end

      if response.code == "200"
        begin
          JSON.parse(response.body)
        rescue JSON::ParserError
          { response: response.body }
        end
      elsif response.code == "400"
        raise BlockchainNode::Errors::BadRequest.new(response.body)
      elsif response.code == "401"
        raise BlockchainNode::Errors::UnAuthorized.new(response.body)
      else
        raise BlockchainNode::Errors::Unknown.new("#{response.code} #{response.body}")
      end

    end

  end
end
