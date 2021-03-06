# BlockchainNode (BCN) Ruby Client

[![Gem Version](https://badge.fury.io/rb/blockchain-node.svg)](https://badge.fury.io/rb/blockchain-node)

This gem is a secure RPC wrapper to connect to nodes launched by 
[https://blockchainnode.io](https://blockchainnode.io). 

## Installation and Configuration

```bash
gem install blockchain-node
```

The client is secured using a client-credentials OAUTH flow. You can generate API keys in your BCN account. 

If you are using a Rails application, add the following initializer to `config/initializers/blockchain_node.rb`
 
```ruby
BlockchainNode.configure do |config|
  config.client_id = "CLIENT_ID"
  config.client_secret = "CLIENT_SECRET"
end
```

**Security Note:**
It is recommended that you secure your `CLIENT_ID` and `CLIENT_SECRET` and do not check that into your code repo.
If your `CLIENT_ID` and `CLIENT_SECRET` are compromised, your wallet will be secure as long as it is
encrypted and not left unlocked.


## Usage

### Initialize the library

```ruby
# the node ID from your BCN console
node_id = "123ABC"
client = BlockchainNode::Client.new(node_id)
```

Make RPC method calls directly. Pass in parameters as args to the method call.

Other helper methods: 

```ruby
# returns a list of nodes you have running on your account
client.nodes
```

### Bitcoin Example


[List of Bitcoin RPC Calls](README-RPC-BTC.md)

### Ethereum Example


Notice, for geth, responses are returned in hex so they have to be converted to an integer.

Balances are stored as integers with 18 decimals of spacing (wei).  Convert to ether.
[Helpful Calculator](https://etherconverter.online/) 

```ruby
resp = client.eth_blockNumber
Integer(resp[:response])

client.personal_listAccounts

resp = client.eth_getBalance("0xf4c2a25fcbaad4e568fb74d6644b164e999d3132", "latest")
Integer(resp[:response]) / 1000000000000000000.0
```

[List of Ethereum (geth) RPC Calls](README-RPC-ETH.md)

## Contact

Comments and feedback are welcome. Send an email to matt at blockchainnode.io.

## License

This code is free to use under the terms of the MIT license.