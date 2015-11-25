require 'json'

class Daredevel::Client

  def send_data data
    socket = TCPSocket.new 'localhost', 4242
    socket.write data
    ret = JSON.parse socket.read
    if ret['success']
      puts ret['success']
    else
      puts ret['error']
    end
  ensure
    socket.close
  end

  def start
    data = JSON.dump action: :start, args: [File.basename(Dir.pwd), Dir.pwd]
    self.send_data data
  end

end
