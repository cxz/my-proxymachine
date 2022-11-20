require 'rubygems'
require 'socket'
require 'eventmachine'

# A simple echo server to use in tests
module EventMachine
  module Protocols
    class TestConnection < Connection
      def self.start(host, port)
        @@port = port
        EM.start_server(host, port, self)
      end

      def receive_data(data)
        sleep $1.to_f if data =~ /^sleep (.*)/
        puts("<\t #{data}")
        send_data("#{@@port}:#{data}")
        # close_connection_after_writing
      end
    end
  end
end

port = ARGV[0]

EM.run do
  puts("running port #{port}")
  EventMachine::Protocols::TestConnection.start('localhost', port)
end
