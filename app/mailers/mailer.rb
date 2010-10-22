# encoding: utf-8
class Mailer < ActionMailer::Base
  default :from => DEFAULT_MAILER_RECIPIENT, :to => DEFAULT_MAILER_RECIPIENT
  
  def device_state_changed(device)
    @device = device
    mail(:subject => "#{@device}: #{@device.current_state_name}")
  end
  
end
