require 'celluloid/io'

class Daredevel::Manager
  include Celluloid::IO

  attr_accessor :server

  def initialize server
    self.server = server
    @socket = TCPServer.new('127.0.0.1', 4242)
    async.run
  end

  def run
    while @socket
      async.handle_connection(@socket.accept)
    end
  end

  def handle_connection socket
    
  end

end
