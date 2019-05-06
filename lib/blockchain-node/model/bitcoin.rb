module BlockchainNode
  module Model
    class Bitcoin < Base

      def blockchain
        'bitcoin'
      end

      def wallet_info
        @client.getwalletinfo
      end

      def total_balance
        @client.getbalance
      end

      def account_balances(account = "")
        @client.listaddressgroupings
      end

      def new_address(account = "")
        @client.getnewaddress(account)
      end

      def send_transaction(address, amount)
        @client.sendtoaddress(address, amount)
      end

    end
  end
end
