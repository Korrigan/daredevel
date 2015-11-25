class Daredevel::Environment
  attr_accessor :name, :directory

  def initialize name, directory
    self.name = name
  end

  def loopback
    @loopback ||= '127.0.0.1'
  end

end
