class IndexerJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    establish_tor_circuit
    TCPSocket::socks_server = "127.0.0.1"
    TCPSocket::socks_port = 9051
    args.map do |u|
      Net::HTTP.get('u')
    end
  end

  private

  def establish_tor_circuit
    TorControl.password = ""
    TorControl.host = "localhost"
    TorControl.port = 9051
    TorControl.connect
    TorControl.authenticate
    TorControl.new_identitiy
  end

  def close_tor_circuit
    TorControl.close
  end
end
