require 'json'

class Daredevel::Manager::Request

  attr_accessor :action, :args

  def initialize socket
    JSON.parse(socket.read).tap do |data|
      self.action = data['action']
      self.args = data['args']
    end
  end

end
