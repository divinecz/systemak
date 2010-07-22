require "open-uri"
module DeviceReader
  class HttpReader

    attr_accessor :ip_address

    def initialize(ip_address)
      @ip_address = ip_address
    end

    def raw_read(log_address)
      open("http://#{@ip_address}/logy.txt?A35=#{log_address.to_address}").read
    end

    def raw_status
      open("http://#{@ip_address}/sw1.txt").read
    end

  end
end