class DeviceRefreshTask < Scheduler::SchedulerTask
  environments :all

  every '5s'

  def run
    puts "Refreshing devices..."
    refresh_devices
    puts "All devices have been refreshed!"
  end

  def refresh_devices
    Device.all.each do |device|
      device.refresh!
    end
  end
end
