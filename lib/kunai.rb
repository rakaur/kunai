ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# Set up gems listed in the Gemfile
require "bundler/setup"

# Require stdlib files
require "socket"
require "yaml"

# Require our files here and only here
require_relative "kunai/client"
require_relative "kunai/configuration"
require_relative "kunai/support"

module Kunai
  VERSION = "0.1.0"

  class << self
    attr_reader :config

    def env
      config.env ||= :development
    end

    def initialize!(options)
      @config = Configuration.new
      @config.file = options[:config].presence || "config/ircd.yml"
      @config.ircd = Configuration.new(YAML.load_file(@config.file))
      config.env = options[:env]

      @clients = {}
      @servers = []

      @callbacks = {}

      initialize_callbacks
    rescue StandardError => e
      puts "kunai: error during initialization"
      puts e
      raise
    else
      start
      true
    end

    # :nocov:
    def start
      puts "kunai #{Kunai::VERSION} running in #{config.env} mode"

      @servers = config.ircd.listen.map { |l| TCPServer.new(l.host, l.port) }

      loop do
        readfds = @clients.values.filter_map(&:socket) + @servers
        writefds = @clients.values.filter_map { |c| c.socket if c.need_write? }

        read, write, _ = IO.select(readfds, writefds, nil, 5)

        read&.each do |s|
          if s.is_a?(TCPServer)
            @callbacks[:accept_ready].each { |cb| cb.(s) }
          elsif s.is_a?(TCPSocket)
            @callbacks[:read_ready].each { |cb| cb.(s) }
          end
        end

        write&.each do |s|
          @callbacks[:write_ready].each { |cb| cb.(s) }
        end
      end
    end

    private
      def initialize_callbacks
        @callbacks[:accept_ready] = []
        @callbacks[:read_ready] = []
        @callbacks[:write_ready] = []

        @callbacks[:accept_ready] << lambda do |socket|
          client = socket.accept_nonblock
          @clients[client.hash] = Client.new(client)
        end

        @callbacks[:read_ready] << lambda do |socket|
          @clients[socket.hash].read
        rescue EOFError
          @clients.delete(socket.hash)
        end

        @callbacks[:write_ready] << lambda do |socket|
          @clients[socket.hash].flush
        rescue EOFError
          @clients.delete(socket.hash)
        end
      end
  end
end
