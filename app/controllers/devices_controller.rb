# encoding: utf-8
class DevicesController < ApplicationController
  def index
    @devices = Device.all
  end

  def show
    @device = Device.find_by_param!(params[:id])
  end

  def new
    @device = Device.new
  end

  def create
    @device = Device.new(params[:device])
    if @device.save
      flash[:notice] = "Zařízení bylo přidáno."
      redirect_to @device
    else
      render :action => 'new'
    end
  end

  def edit
    @device = Device.find_by_param!(params[:id])
  end

  def update
    @device = Device.find_by_param!(params[:id])
    case params[:device][:current_state]
    when "online"
      @device.online! unless @device.online?
      redirect_to @device, :notice => "Zařízení bylo aktivováno."
    when "offline"
      @device.offline! unless @device.offline?
      redirect_to @device, :notice => "Zařízení bylo deaktivováno."
    else
      if @device.update_attributes(params[:device])
        redirect_to @device, :notice => "Zařízení bylo upraveno."
      else
        render :action => 'edit'
      end
    end
  end

  def destroy
    @device = Device.find_by_param!(params[:id])
    @device.destroy
    flash[:notice] = "Zařízení bylo odstraněno."
    redirect_to devices_path
  end

  def import_log
    @device = Device.find_by_param!(params[:id])
    if file = params[:file]
      imported = 0
      file.read.scan(/(\w{16})/).flatten.each do |data|
        @device.packets.create(:address => imported * 8, :raw_data => data.lines.to_a.pack("H*"))
        imported += 1
      end
      flash[:notice] = "Bylo importováno #{imported} paketů."
    end
    redirect_to devices_path
  end
end
