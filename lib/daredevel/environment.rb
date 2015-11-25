class Daredevel::Environment
  attr_accessor :name, :loopback

  def initialize name
    self.name = name
    self.loopback = '127.0.0.1'
  end
end
