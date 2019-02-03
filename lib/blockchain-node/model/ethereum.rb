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
        Integer(resp[:response]) / DECIMALS_18
      end

      def unlock(account, password, seconds = 30)
        @client.personal_unlockAccount(account, password, seconds)
      end

      def send(from, to, ether)
        wei_to_send = (ether * DECIMALS_18).round
        value = '0x' + wei_to_send.to_s(16)
        tx = { from: from,  to: to,  value: value }
        @client.eth_sendTransaction(tx)
      end

      def unlock_and_send(password, from, to, ether)
        unlock(from, password, 10)
        send(from, to, ether)
      end

    end
  end
end

