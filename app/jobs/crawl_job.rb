class CrawlJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :default

  def perform(args)
    logger.debug args.inspect
    establish_tor_circuit
    TCPSocket::socks_server = "127.0.0.1"
    TCPSocket::socks_port = 9050
    uri = URI("http://#{args.onion_url}")
    res = Net::HTTP.get(uri).force_encoding(Encoding::UTF_8)
    relative_urls = res.scan(/.*href="(\S*)"/)
    # text_only = CGI::unescapeHTML(res.gsub(/<[^>]*>/,""))
    onion_urls = res.scan(/(http(s)?\:\/\/)?([A-z0-9]{16}\.onion)(\/)?([^\"](.)*[^\"])?/)
    base_url = args.base_url
    site = Site.find_by({ base_url: base_url })
    if site.nil?
      site = Site.new({ base_url: base_url })
    end
    logger.debug res
    relative_urls.each do |u|
      sanitized = sanitize_relative_url args.base_url, u
      logger.debug "relative url: #{u}"
      c = CrawlRequest.create({ onion_url: "#{sanitized}" })
      c.save
    end
    onion_urls.each do |o|
      begin
        logger.debug "onion url found: #{o.join()}"
        c = CrawlRequest.create({ onion_url: o.join() })
        c.save
      rescue
        logger.debug "Error for: #{o.join()}"
      end
    end
    close_tor_circuit
  end

  private

  def sanitize_relative_url base, rel
    if url.start_with? "//"
      return "http:#{url}"
    elsif url.start_with? "/"
      return "http://#{base}#{rel}"
    elsif url.start_with? "http:"
      return rel
    end
  end

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
