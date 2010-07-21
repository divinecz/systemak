# encoding: utf-8
class PacketsController < ApplicationController

  respond_to :html, :json

  def index
    if params[:device_id]
      @device = Device.find(params[:device_id])
      @packets = @device.packets
    else
      @packets = Packet.all#(:conditions => ["DATE(created_at) = ?", Date.today])
    end
    respond_with(@packets) do |format|
      format.json{ render :json => @packets.collect(&:to_sproutcore_hash) }
    end
  end

  def show
    @device = Device.find(params[:device_id])
    @packet = @device.packets.find(params[:id])
  end

  def destroy
    @device = Device.find(params[:device_id])
    @packet = @device.packets.find(params[:id])
    @packet.destroy
    flash[:notice] = "Paket `byl odstraněn."
    redirect_to [@device, :packets]
  end
end
