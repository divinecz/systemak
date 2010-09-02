# encoding: utf-8
class PacketsController < ApplicationController
  def index
    @device = Device.find(params[:device_id])
    @packets = @device.packets.paginate(:page => params[:page], :order => "id DESC")
  end
  
  def show
    @device = Device.find(params[:device_id])
    @packet = @device.packets.find(params[:id])
  end
  
  def destroy
    @device = Device.find(params[:device_id])
    @packet = @device.packets.find(params[:id])
    @packet.destroy
    flash[:notice] = "Paket byl odstraněn."
    redirect_to [@device, :packets]
  end
end
