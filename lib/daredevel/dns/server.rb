require 'celluloid/dns'

class Daredevel::DNS::Server < Celluloid::DNS::Server
  attr_accessor :server

  def process name, resource_class, transaction
    env = self.server.environment_from_dns_name name
    if resource_class.name == Resolv::DNS::Resource::IN::A.name && env
      transaction.respond! env.loopback
    else
      transaction.fail! :NXDomain
    end
  end

  def initialize server
    self.server = server
    ifaces = [:udp, :tcp].map do |proto|
      [proto, '0.0.0.0', 5300]
    end
    super listen: ifaces
  end

end
