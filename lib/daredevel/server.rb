require 'celluloid'

class Daredevel::Server
  attr_accessor :environments

  def managed_domain? name
    self.environments.any? do |env|
      name == env.name || name.end_with?(".#{env.name}")
    end
  end

  def run *args
    Daredevel::DNSServer.new(self).run
    Daredevel::Manager.new(self).run
    sleep
  end
end
