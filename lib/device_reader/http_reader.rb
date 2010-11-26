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

    def read_raw(file, query = {})
      read_delay
      file = "/#{file}"
      uri = URI::HTTP.build(:host => @ip_address, :path => file, :query => query.to_query).to_s
      open(uri).read
    end

    def read_raw_log(log_address)
      read_raw("logy.txt", { "A35" => log_address.to_address })
    end

    def read_raw_status
      read_raw("sw1.txt")
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