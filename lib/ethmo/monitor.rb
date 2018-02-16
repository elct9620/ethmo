# frozen_string_literal: true

module Ethmo
  # :nodoc:
  class Monitor
    include Enumerable

    def initialize(type = 'newHeads')
      @conn = IPCSocket.new(Config.socket)
      @type = type
      @thread = nil
      @stop = false
      @queue = Queue.new
    end

    def each(&_block)
      yield @queue.pop until stop?
    end

    def start
      return if @thread
      subscribe!
      @thread = Thread.new { process until stop? }
    end

    def stop?
      @stop == true
    end

    def stop
      @stop = true
    end

    protected

    def process
      event = @conn.read
      return sleep 1 if event.nil?
      @queue << JSON.parse(event)
    end

    def subscribe!
      # TODO: Add options support
      @conn.exec('eth_subscribe', @type, {})
      JSON.parse(@conn.read)
    end
  end
end
