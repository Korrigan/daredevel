require 'celluloid/io'

class Daredevel::Manager::Server
  include Celluloid::IO

  attr_accessor :server

  ACTIONS = ['start']

  def initialize server
    self.server = server
    @socket = TCPServer.new('127.0.0.1', 4242)
  end

  def run
    Celluloid.logger.info self.class.name do "Manager started" end
    async.handle_connections
  end

  def handle_connections
    async.handle_connection(@socket.accept) while @socket
  end

  def handle_connection socket
    _, remote_port, remote_host = socket.peeraddr
    Celluloid.logger.info self.class.name do
      "Received connection from #{remote_host}:#{remote_port}"
    end
    response = self.process Daredevel::Manager::Request.new(socket)
    Celluloid.logger.info self.class.name do
      "[#{response.first.first.upcase}] #{response.first.last}"
    end
    socket.write JSON.dump(response)
  ensure
    socket.close
  end

  def process request
    if ACTIONS.include?(request.action)
      self.send request.action, *request.args
    else
      return {error: "Invalid action #{request.action} #{request.args}"}
    end
  end

  def start name, directory
    return {error: "#{name} is already started"} if self.server.environment_exists? name
    self.server.environments << Daredevel::Environment.new(name, directory)
    return {success: "Started environment #{name}"}
  end

end
