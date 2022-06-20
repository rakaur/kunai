module Kunai
  class Client
    attr_reader :socket

    def initialize(socket)
      @sendq = []
      @recvq = []
      @socket = socket
    end

    def need_write?
      @sendq.present?
    end

    def write(string)
      @sendq << string
    end

    def flush
      loop do
        break unless line = @sendq.shift
        @socket.write_nonblock(line + "\r\n")
      rescue IO::WaitWritable
        @sendq.unshift(line)
        break
      end
    end

    def read
      loop do
        break unless line = @socket.read_nonblock(512)
        @recvq << line.chomp
      rescue IO::WaitReadable
        break
      end

      parse
    end

    def parse
      while line = @recvq.shift
        write line
      end
    end
  end
end
