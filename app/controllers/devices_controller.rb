# encoding: utf-8
class DevicesController < ApplicationController
  def index
    @devices = Device.all
  end
  
  def show
    @device = Device.find(params[:id])
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
    @device = Device.find(params[:id])
  end
  
  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(params[:device])
      flash[:notice] = "Zařízení bylo upraveno."
      redirect_to @device
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    flash[:notice] = "Zařízení bylo odstraněno."
    redirect_to devices_url
  end
end
