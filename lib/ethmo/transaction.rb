# frozen_string_literal: true

module Ethmo
  # :nodoc:
  class Transaction < Hash
    def initialize(hash)
      # TODO: Add read transaction from hash support
      # NOTE: Current only support direct merge transaction
      merge! hash
    end

    def transfer?
      value.positive?
    end

    def contract?
      to.nil?
    end

    def from
      self['from']
    end

    def to
      self['to']
    end

    def value
      @value ||=
        fetch('value', '0x0')
        .to_i(16)
        .to_f / Config::WEI
    end
  end
end
