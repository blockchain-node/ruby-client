module BlockchainNode
  module Model
    class Ethereum < Base

      DECIMALS_18 = 1000000000000000000.0

      def blockchain
        'ethereum'
      end

      def accounts
        @client.personal_listAccounts
      end

      def balanceOf(account)
        resp = @client.eth_getBalance(account, 'latest')
        hex_to_int(resp[:response]) / DECIMALS_18
      end

      def unlock(account, password, seconds = 30)
        @client.personal_unlockAccount(account, password, seconds)
      end

      # sends a transaction. Returns the transaction ID
      def send(from, to, ether)
        wei_to_send = (ether * DECIMALS_18).round
        value = '0x' + wei_to_send.to_s(16)
        tx = { from: from,  to: to,  value: value }
        @client.eth_sendTransaction(tx)[:response]
      end

      def unlock_and_send(password, from, to, ether)
        unlock(from, password, 10)
        send(from, to, ether)
      end

      def highest_block
        hex_to_int(@client.eth_blockNumber[:response])
      end

      def transactions_for_account(account, startBlock = nil, endBlock = nil)
        endBlock = highest_block if endBlock.nil?
        startBlock = endBlock - 1000 if startBlock.nil?
        account.downcase!

        found_transactions = []

        (startBlock..endBlock).each do |block|
          response = @client.eth_getBlockByNumber(int_to_hex(block), true)
          found_transactions += response["transactions"].select{ |t| t["from"].try(:downcase) == account || t["to"].try(:downcase) == account }
        end

        found_transactions
      end

      private

      def hex_to_int(hex)
        Integer(hex)
      end

      def int_to_hex(int)
        '0x' + int.to_s(16)
      end

    end
  end
end

