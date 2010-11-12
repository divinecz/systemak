# encoding: utf-8
class PacketsController < ApplicationController

  DEFAULT_PACKETS_LIMIT = 32

  def index
    @device = Device.find_by_param!(params[:device_id])
    @packets = @device.packets
    respond_to do |format|
      format.html do
        @packets = @packets.paginate(:page => params[:page], :order => "sequence_id DESC")
      end
      format.json do
        sequence_id ||= params[:sequence_id].to_i
        limit = params[:limit].to_i
        limit = DEFAULT_PACKETS_LIMIT if limit <= 0
        render :json => @packets.from_sequence_id(sequence_id).order("sequence_id ASC").limit(limit).to_json(:only => [:sequence_id], :methods => [:data])
      end
    end
  end

  def show
    @device = Device.find_by_param!(params[:device_id])
    @packet = @device.packets.find_by_sequence_id!(params[:id])
    respond_to do |format|
      format.json do
        render :json => @packet.to_json(:only => [:sequence_id], :methods => [:data])
      end
    end
  end

  def destroy
    @device = Device.find_by_param!(params[:device_id])
    @packet = @device.packets.find_by_sequence_id!(params[:id])
    @packet.destroy
    flash[:notice] = "Paket byl odstraněn."
    redirect_to [@device, :packets]
  end
end
