# encoding: utf-8
class Mailer < ActionMailer::Base
  default :from => "martin@hladil.name", :to => "martin@hladil.name"
  
  def device_state_changed(device)
    @device = device
    mail(:subject => "#{@device}: #{@device.current_state_name}")
  end
  
end
