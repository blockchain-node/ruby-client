# Ethereum RPC Methods Calls


## Personal

The personal API manages private keys in the key store.

### personal_listAccounts

Returns all the Ethereum account addresses of all keys in the key store.


#### Example

``` ruby
client.personal_listAccounts
 => ["0x5e97870f263700f46aa00d967821199b9bc5a120", "0x3d80b31a78c30fc628f20b2c89d7ddbf6e53cedc"]
```



### personal_newAccount

Generates a new private key and stores it in the key store directory.
The key file is encrypted with the given passphrase.
Returns the address of the new account.

#### Parameters

| Name         | Optional  | Description                                |
| :----------: | --------- | ------------------------------------------ |
| password     | yes       | The password to use to encrypt the wallet  |

#### Response

The address of the new account.

#### Example
 
``` ruby
client.personal_newAccount('SecurePassword')
 => {:response=>"0x4e6f002a07a7e5f74fdaaa6e730557782405fa05"} 
```


## Blockchain Methods

### eth_getBalance

Returns the balance of the account of given address at a given block.

#### Parameters

| Name         | Optional  | Description                                |
| :----------: | --------- | ------------------------------------------ |
| address      | no        |  The address to check for balance.  |
| block        | no        | QUANTITY|TAG - integer block number, or the string "latest", "earliest" or "pending" |

#### Response

`QUANTITY` - integer of the current balance in wei in hex.


#### Example
 
``` ruby
client.eth_getBalance('0x5e97870f263700f46aa00d967821199b9bc5a120', 'latest')
 => {:response=>"0x4e6f002a07a7e5f74fdaaa6e730557782405fa05"} 
```




## Reference: ALL ETH / WEB METHODS

```

web3_clientVersion
web3_sha3
net_version
net_peerCount
net_listening
eth_protocolVersion
eth_syncing
eth_coinbase
eth_mining
eth_hashrate
eth_gasPrice
eth_accounts
eth_blockNumber
eth_getBalance
eth_getStorageAt
eth_getTransactionCount
eth_getBlockTransactionCountByHash
eth_getBlockTransactionCountByNumber
eth_getUncleCountByBlockHash
eth_getUncleCountByBlockNumber
eth_getCode
eth_sign
eth_sendTransaction
eth_sendRawTransaction
eth_call
eth_estimateGas
eth_getBlockByHash
eth_getBlockByNumber
eth_getTransactionByHash
eth_getTransactionByBlockHashAndIndex
eth_getTransactionByBlockNumberAndIndex
eth_getTransactionReceipt
eth_getUncleByBlockHashAndIndex
eth_getUncleByBlockNumberAndIndex
eth_getCompilers
eth_compileLLL
eth_compileSolidity
eth_compileSerpent
eth_newFilter
eth_newBlockFilter
eth_newPendingTransactionFilter
eth_uninstallFilter
eth_getFilterChanges
eth_getFilterLogs
eth_getLogs
eth_getWork
eth_submitWork
eth_submitHashrate
eth_getProof
db_putString
db_getString
db_putHex
db_getHex


```
