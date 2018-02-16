# frozen_string_literal: true

module Ethmo
  class Monitor
    # :nodoc:
    class NewHead < Hash
      def initialize(event)
        merge! event.dig('params', 'result')
      end

      # TODO: Add methods for others attribute

      def hash
        self['hash']
      end
    end
  end
end
