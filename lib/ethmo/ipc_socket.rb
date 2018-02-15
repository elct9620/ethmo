# frozen_string_literal: true

module Ethmo
  # :nodoc;
  class IPCSocket < UNIXSocket
    class << self
      def next_id
        @id ||= 1
        @id += 1
      end
    end

    VERSION = '2.0'

    attr_reader :id

    def initialize(path)
      @buffer = ''
      @id = self.class.next_id
      super
    end

    def exec(method, *params)
      send({
        id: id,
        jsonrpc: VERSION,
        method: method,
        params: params
      }.to_json, 0)
    end

    def read
      @buffer = @buffer.to_s + recv(1024) until @buffer.to_s.include?("\n")
      (_, @buffer = @buffer.to_s.split("\n", 2)).first
    end
  end
end
