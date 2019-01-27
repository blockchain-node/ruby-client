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
      expect_any_instance_of(BlockchainNode::Request).to receive(:process_request).exactly(3).times.and_return(
        {
          "access_token" => "a9b29c6810ba513f08f87fafadaa6154690f9246aa663b1b708c1c94a5887386",
          "expires_in"  => 7200, "created_at"  => Time.now.to_i
        }
      )
      client = BlockchainNode::Client.new(NODE_ID)
      client.auth_token
      Timecop.travel(Time.now + 7300)
      client.auth_token
      Timecop.travel(Time.now + 7200)
      client.auth_token
    end
  end

  describe "api calls" do
    it "should make a successful API call" do
      stub_oauth
      stub_basic_method

      client = BlockchainNode::Client.new(NODE_ID)
      response = client.eth_blockNumber
      expect(Integer(response[:response])).to eq 4666
    end
  end

end
