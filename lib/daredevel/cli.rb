module Daredevel::CLI
  COMMANDS = ['server']

  def self.server ip = "0.0.0.0", port = "5300"
    Daredevel::Server.run
  end

  def self.usage
    p "Usage: daredevel command [ip] [port]"
  end

  def self.execute command = nil, *args
    return self.usage unless COMMANDS.include? command
    self.send command, *args
  end
end
