# frozen_string_literal: true

module Ethmo
  # :nodoc:
  class Config
    include Singleton

    class << self
      def respond_to_missing?(*args)
        instance.respond_to_missing?(*args)
      end

      def method_missing(name, *args, &block)
        return instance.send(name, *args, &block) if instance.respond_to?(name)
        super
      end
    end

    attr_accessor :socket
  end
end
