require 'json'

CLIENT_ID = "12345ABC"
CLIENT_SECRET = "1234567890ABCDEFG"
NODE_ID = "ABC123"

OAUTH_REQUEST = { grant_type: "client_credentials", client_id: CLIENT_ID, client_secret: CLIENT_SECRET }
OAUTH_RESPONSE = {
  access_token: "a9b29c6810ba513f08f87fafadaa6154690f9246aa663b1b708c1c94a5887386",
  token_type: "Bearer",
  expires_in: 7200,
  created_at: Time.now.to_i
}
def stub_oauth
  stub_request(:post, "#{BlockchainNode::Request::DEFAULT_BASE_URL}/oauth/token").
    with(body: OAUTH_REQUEST ).
    to_return(status: 200, body: OAUTH_RESPONSE.to_json)
end

def stub_get_node
  stub_request(:get, "#{BlockchainNode::Request::DEFAULT_BASE_URL}/api/nodes/#{NODE_ID}").
    to_return(status: 200, body: "{\"id\":\"#{NODE_ID}\",\"blockchain\":\"bitcoin\",\"network\":\"testnet\",\"status\":\"RUNNING\",\"height\":1454086}"  )
end

def stub_get_nodes
  stub_request(:get, "#{BlockchainNode::Request::DEFAULT_BASE_URL}/api/nodes").
    to_return(status: 200, body: "{\"nodes\":[{\"id\":\"#{NODE_ID}\",\"blockchain\":\"bitcoin\",\"network\":\"testnet\",\"status\":\"RUNNING\",\"height\":1454086}]}"  )
end

def stub_basic_method
  stub_request(:post, "#{BlockchainNode::Request::DEFAULT_BASE_URL}/api/nodes/#{NODE_ID}").
    with(body: api_method_body('eth_blockNumber')).
    to_return(status: 200, body: '0x123A')
end


def api_method_body(method, *params)
  {
    method: method,
    parameters: params
  }.to_json
end

# ethereum mocks
ETHEREUM_ACCOUNT = "0x829bd824b016326a401d083b33d092293333a830"
ETHEREUM_TRANSACTION = "0x2e9a95887534709e23ba62a54679cfb073b819847be1fd039c1517b851354923"
def stub_ethereum_list_accounts
  stub_request(:post, "#{BlockchainNode::Request::DEFAULT_BASE_URL}/api/nodes/#{NODE_ID}").
    to_return(status: 200, body: "[\"#{ETHEREUM_ACCOUNT}\"]"  )
end
def stub_ethereum_balance_of
  stub_request(:post, "#{BlockchainNode::Request::DEFAULT_BASE_URL}/api/nodes/#{NODE_ID}").
    to_return(status: 200, body: "0x8ac7230489e80000"  )
end
def stub_ethereum_highest_block
  stub_request(:post, "#{BlockchainNode::Request::DEFAULT_BASE_URL}/api/nodes/#{NODE_ID}").
    to_return(status: 200, body: "0x4bdfd0"  )
end
def stub_ethereum_send
  stub_request(:post, "#{BlockchainNode::Request::DEFAULT_BASE_URL}/api/nodes/#{NODE_ID}").
    with(body: '{"method":"eth_sendTransaction","parameters":[{"from":"ACCOUNT1","to":"ACCOUNT2","value":"0xde0b6b3a7640000"}]}').
    to_return(status: 200, body: ETHEREUM_TRANSACTION  )
end
