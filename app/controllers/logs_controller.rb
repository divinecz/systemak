class LogsController < ApplicationController
  def index
    @device = Device.find(params[:device_id])
    @logs = @device.logs
  end
  
  def show
    @device = Device.find(params[:device_id])
    @log = @device.logs.find(params[:id])
  end
  
  def destroy
    @device = Device.find(params[:device_id])
    @log = @device.logs.find(params[:id])
    @log.destroy
    flash[:notice] = "Successfully destroyed log."
    redirect_to [@device, :logs]
  end
end
