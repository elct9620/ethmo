# frozen_string_literal: true

module Ethmo
  # :nodoc:
  class Block < Hash
    def initialize(hash)
      merge! Client.block_from(hash, true).dig('result')
    end

    def transactions
      @transactions ||=
        self['transactions']
        .map { |tx| Transaction.new(tx) }
    end
  end
end
