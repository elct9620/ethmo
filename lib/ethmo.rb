# frozen_string_literal: true

require 'socket'
require 'singleton'
require 'json'

require 'ethmo/version'

# :nodoc
module Ethmo
  autoload :IPCSocket, 'ethmo/ipc_socket'
  autoload :Config,    'ethmo/config'
  autoload :Client,    'ethmo/client'
  autoload :Account,   'ethmo/account'

  class << self
    def config(&block)
      Config.instance_exec(Config.instance, &block)
    end
  end
end
