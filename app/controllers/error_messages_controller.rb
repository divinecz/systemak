# encoding: utf-8
class ErrorMessagesController < ApplicationController
  def index
    @device = Device.find(params[:device_id])
    @error_messages = @device.error_messages.paginate(:page => params[:page], :order => "id DESC")
  end

  def show
    @device = Device.find(params[:device_id])
    @error_message = @device.error_messages.find(params[:id])
  end

  def destroy
    @device = Device.find(params[:device_id])
    @error_message = @device.error_messages.find(params[:id])
    @error_message.destroy
    flash[:notice] = "Chybová zpráva byla odstraněna."
    redirect_to [@device, :error_messages]
  end
end
