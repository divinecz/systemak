class DeviceRefreshTask < Scheduler::SchedulerTask
  environments :all

  every '15s', :blocking => true

  def run
    puts "Refreshing devices..."
    refresh_devices
    puts "All devices have been refreshed!"
  end

  def refresh_devices
    Device.not_offline.lock.each do |device|
      device.refresh!
    end
  end
end
