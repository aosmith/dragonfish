class CrawlJob < ActiveJob::Base
  queue_as :default

  def perform(args)
    establish_tor_circuit
    TCPSocket::socks_server = "127.0.0.1"
    TCPSocket::socks_port = 9050
    uri = URI("http://#{args.onion_url}")
    res = Net::HTTP.get(uri)
    logger.debug res
  end

  private

  def establish_tor_circuit
    TorControl.password = "TBm8mFTd9mm8qxrRXoARQRHkrfM219WtxSkSejN48Lv"
    TorControl.host = "localhost"
    TorControl.control_port = 9051
    TorControl.connect
    TorControl.authenticate
    TorControl.new_identity
  end

  def close_tor_circuit
    TorControl.close
  end
end
