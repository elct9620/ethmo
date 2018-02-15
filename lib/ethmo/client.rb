# frozen_string_literal: true

module Ethmo
  # :nodoc:
  class Client
    include Singleton

    class << self
      def respond_to_missing?(*args)
        instance.respond_to_missing?(*args)
      end

      def method_missing(name, *args, &block)
        return super unless instance.respond_to?(name)
        instance.public_send(name, *args, &block)
      end
    end

    AVAILABLE_METHOD = {
      balance_of: 'eth_getBalance'
    }.freeze

    def initialize
      # TODO: Add support for WebSocket and others
      @conn = IPCSocket.new(Config.socket)
    end

    def respond_to_missing?(name, include_private = false)
      AVAILABLE_METHOD.keys.include?(name) || super
    end

    def method_missing(name, *args, &block)
      return super unless AVAILABLE_METHOD.keys.include?(name)
      @conn.exec(AVAILABLE_METHOD[name], *args)
      JSON.parse(@conn.read)
    end
  end
end
