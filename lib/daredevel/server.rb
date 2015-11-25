require 'celluloid'

require_relative 'dns'
require_relative 'manager'
require_relative 'environment'

class Daredevel::Server
  attr_accessor :environments

  def initialize
    self.environments = []
  end

  def environment_from_dns_name name
    self.environments.find do |env|
      name == env.name || name.end_with?(".#{env.name}")
    end
  end

  def environment_exists? name
    self.environments.any? do |env|
      name == env.name
    end
  end

  def run *args
    Daredevel::DNS::Server.new(self).run
    Daredevel::Manager::Server.new(self).run
    sleep
  end
end
