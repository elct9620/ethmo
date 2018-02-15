# frozen_string_literal: true

module Ethmo
  # :nodoc:
  class Account
    attr_reader :address

    def initialize(address)
      @address = address
    end

    def balance
      # TODO: Add ETH value to Float Helper
      Client
        .balance_of(address, 'latest')
        .fetch('result', '0x0')
        .to_i(16)
        .to_f / Config::WEI
    end
  end
end
