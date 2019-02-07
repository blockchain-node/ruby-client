require 'spec_helper'

describe BlockchainNode::Model::Ethereum do

  before :all do
    BlockchainNode.configure do |config|
      config.client_id = CLIENT_ID
      config.client_secret = CLIENT_SECRET
      config.request_options = { }
    end

    @client = BlockchainNode::Client.new(NODE_ID)
    @model = BlockchainNode::Model::Ethereum.new(@client)
  end

  before :each do
    stub_oauth
  end

  it "returns a list of accounts" do
    stub_ethereum_list_accounts
    expect(@model.accounts.first).to eq(ETHEREUM_ACCOUNT)
  end

  it "returns a balance of account" do
    stub_ethereum_balance_of
    expect(@model.balanceOf(ETHEREUM_ACCOUNT)).to eq(10)
  end

  it "returns the highest block" do
    stub_ethereum_highest_block
    expect(@model.highest_block).to eq(4972496)
  end

  it "returns sends" do
    stub_ethereum_send
    expect(@model.send("ACCOUNT1", "ACCOUNT2", 1.0)).to eq(ETHEREUM_TRANSACTION)
  end

end
