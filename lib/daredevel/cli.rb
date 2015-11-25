module Daredevel::CLI
  COMMANDS = ['server', 'start']

  def self.start
    Daredevel::Client.new.start
  end

  def self.server ip = "0.0.0.0", port = "5300"
    Daredevel::Server.new.run
  end

  def self.usage
    puts "Usage: daredevel command [args...]"
  end

  def self.execute command = nil, *args
    return self.usage unless COMMANDS.include? command
    self.send command, *args
  end
end
