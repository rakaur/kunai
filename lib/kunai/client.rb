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
        # :nocov:
        @sendq.unshift(line)
        break
        # :nocov:
      end
    end

    def read
      if (line = @socket.read_nonblock(512)).present?
        @recvq << line.chomp
        parse
      end
    rescue IO::WaitReadable
      # Do nothing, return to select()
    end

    def parse
      while line = @recvq.shift
        write line
      end
    end
  end
end
