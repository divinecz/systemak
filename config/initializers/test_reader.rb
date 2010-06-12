if Rails.env.development?
  DEVICE_TEST_READER = DeviceReader::TestReader.new
end