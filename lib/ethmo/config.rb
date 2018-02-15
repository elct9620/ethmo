# frozen_string_literal: true

module Ethmo
  # :nodoc:
  class Config
    include Singleton

    WEI = 10**18 # 1 ETH = 10^18 Wei

    class << self
      def respond_to_missing?(*args)
        instance.respond_to_missing?(*args)
      end

      def method_missing(name, *args, &block)
        return super unless instance.respond_to?(name)
        instance.public_send(name, *args, &block)
      end
    end

    attr_accessor :socket
  end
end
