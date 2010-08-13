require "open-uri"
module DeviceReader
  class HttpReader

    READ_DELAY = 1000 # ms
    READ_DELAY_SECONDS = READ_DELAY / 1000.0

    attr_accessor :ip_address

    def initialize(ip_address)
      @ip_address = ip_address
      @last_read_at = Time.now - READ_DELAY_SECONDS
    end

    def raw_read(log_address)
      read_delay
      open("http://#{@ip_address}/logy.txt?A35=#{log_address.to_address}").read
    end

    def raw_status
      read_delay
      open("http://#{@ip_address}/sw1.txt").read
    end

    private

    def read_delay
      if (Time.now - @last_read_at) < (READ_DELAY_SECONDS)
        sleep((READ_DELAY_SECONDS) - (Time.now - @last_read_at))
      end
      @last_read_at = Time.now
    end

  end
end