require 'spec_helper'

describe BlockchainNode::Configuration do

  before :each do
    BlockchainNode.configure do |config|
      config.client_id = CLIENT_ID
      config.client_secret = CLIENT_SECRET
      config.request_options = { }
    end
  end

  describe "configuration" do
    it "should be accessible as a class property" do
      expect(BlockchainNode.config[:client_id]).to eq CLIENT_ID
      expect(BlockchainNode.config[:client_secret]).to eq CLIENT_SECRET
    end

    it "should configure properly" do
      client = BlockchainNode::Client.new(NODE_ID)
      expect(client.configuration.client_id).to eq CLIENT_ID
      expect(client.configuration.client_secret).to eq CLIENT_SECRET
    end

    it "should allow api host override" do
      host = "http://localhost:3000"
      BlockchainNode.configure do |config|
        config.request_options = { host: host }
      end
      expect(BlockchainNode.config[:request_options][:host]).to eq host
    end
  end

  describe "oauth tokens" do
    it "requests a new token if 1 is expired" do
      Timecop.travel(Time.new(2019,1,10,12,0,0).utc)

      expect_any_instance_of(BlockchainNode::Request).to receive(:process_request).exactly(3).times.and_return(
        {
          "access_token" => "token1",
          "expires_in"  => 7200, "created_at"  => Time.new(2019,1,10,12,0,0).utc.to_i
        },
        {
          "access_token" => "token2",
          "expires_in"  => 7200, "created_at"  => Time.new(2019,1,10,14,0,0).utc.to_i
        },
        {
          "access_token" => "token3",
          "expires_in"  => 7200, "created_at"  => Time.new(2019,1,10,15,59,45).utc.to_i
        },
      )
      client = BlockchainNode::Client.new(NODE_ID)
      client.auth_token # should get an initial auth token
      expect(client.auth_token).to eq("token1")

      Timecop.travel(Time.new(2019,1,10,14,0,0))
      client.auth_token # should get a new auth token
      expect(client.auth_token).to eq("token2")

      Timecop.travel(Time.new(2019,1,10,15,59,15))
      client.auth_token # should NOT get a new token
      expect(client.auth_token).to eq("token2")

      Timecop.travel(Time.new(2019,1,10,15,59,45))
      client.auth_token # should get a new auth token
      expect(client.auth_token).to eq("token3")
    end
  end

  describe "api calls" do
    it "should return a list of nodes" do
      stub_oauth
      stub_get_nodes
      client = BlockchainNode::Client.new
      resp = client.nodes
      expect(resp["nodes"].first["id"]).to eq(NODE_ID)
    end
    it "should make a successful API call" do
      stub_oauth
      stub_basic_method

      client = BlockchainNode::Client.new(NODE_ID)
      response = client.eth_blockNumber
      expect(Integer(response[:response])).to eq 4666
    end
  end

  describe "client instantiation" do
    it "should allow instantiation without a client id" do
      client = BlockchainNode::Client.new
      expect(client.node_id).to be_nil

      expect{client.details}.to raise_error(BlockchainNode::Errors::ClientNotConfigured)
      client.node_id = NODE_ID

      stub_oauth
      stub_get_node
      resp = client.details
      expect(resp["id"]).to eq(NODE_ID)
    end
  end

end
