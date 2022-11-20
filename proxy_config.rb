# Usage:
#   proxymachine -c proxy_config.rb [-h <host>] [-p <port>]
#
# Options:
#   -c, --config CONFIG              Configuration file
# -h, --host HOST                  Hostname to bind. Default 0.0.0.0
# -p, --port PORT                  Port to listen on. Default 5432

proxy do |data|
  if /open (?<port>\d+)/ =~ data
    { remote: "localhost:#{port}" }
  else
    { :noop => true }
  end
end
