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
    # relative_urls = res.scan(/.*href="(\S*)"/)
    text_only = CGI::unescapeHTML(res.gsub(/<[^>]*>/,""))
    onion_urls = res.scan(/(http(s)?)(:\/\/)([A-z0-9]{16}\.onion[^"|\s|<]*)/)
    Page.create({ url: args.onion_url, html_contnet: res, text_content: text_only })
    onion_urls.each do |o|
      begin
        logger.debug "onion url found: #{o.join()}"
        CrawlRequest.create({ onion_url: o.join() })
      rescue
      end
    end
    close_tor_circuit
  end

  private

  def sanitize_relative_url base, rel
    if rel.is_a? Array
      rel = rel.join
    end
    if rel.start_with? "//"
      return "http:#{url}"
    elsif rel.start_with? "/"
      return "http://#{base}#{rel}"
    elsif rel.start_with? "http:"
      return rel
    end
  end

  def scrape_urls text

  end

  def establish_tor_circuit
    TorControl.password = "TBm8mFTd9mm8qxrRXoARQRHkrfM219WtxSkSejN48Lv"
    TorControl.host = "localhost"
    TorControl.control_port = 9051
    TorControl.connect
    TorControl.authenticate
  end

  def close_tor_circuit
    TorControl.close
  end

end
