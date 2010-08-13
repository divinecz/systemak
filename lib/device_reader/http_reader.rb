require "open-uri"
module DeviceReader
  class HttpReader

    READ_DELAY = 1000 # ms

    attr_accessor :ip_address

    def initialize(ip_address)
      @ip_address = ip_address
      @last_read_at = 0
    end

    def raw_read(log_address)
      if (Time.now - @last_read_at) < (READ_DELAY / 1000.0)
        sleep((READ_DELAY / 1000.0) - (Time.now - @last_read_at))
      end
      data = open("http://#{@ip_address}/logy.txt?A35=#{log_address.to_address}").read
      @last_read_at = Time.now
      return data
    end

    def raw_status
      open("http://#{@ip_address}/sw1.txt").read
    end

  end
end