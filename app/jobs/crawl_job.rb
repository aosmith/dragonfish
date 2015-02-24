class CrawlJob < ActiveJob::Base
  queue_as :default

  def perform(args)
    establish_tor_circuit
    TCPSocket::socks_server = "127.0.0.1"
    TCPSocket::socks_port = 9050
    uri = URI("http://#{args.onion_url}")
    res = Net::HTTP.get(uri).force_encoding(Encoding::UTF_8)
    text_only = CGI::unescapeHTML(res.gsub(/<\/?[^>]*>/,""))
    keywords = Highscore::Content.new text_only, generate_blacklist
    keywords.configure do
      set :short_words_threshold, 4
      set :ignore_case, true
    end
    base_url = args.base_url
    site = Site.find({ base_url: base_url })
    if site.nil?
      site = Site.new({ base_url: base_url })
    end
    keywords.keywords.top(100).each do |keyword|
      existing_kw = Keyword.find_by({ keyword: keyword })
      if existing_kw
      end
    end
    args.indexed = true

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

  def generate_blacklist
    blacklist = Highscore::Blacklist.new
    blacklist << "tor"
    blacklist << "irc"
    blacklist << "for"
    blacklist << "the"
    blacklist << "and"
    blacklist
  end
end
