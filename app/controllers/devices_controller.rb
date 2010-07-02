# encoding: utf-8
class DevicesController < ApplicationController

  respond_to :html, :json

  def index
    respond_with(@devices = Device.all) do |format|
      format.json{ render :json => @devices.collect(&:to_sproutcore_hash) }
    end
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
    respond_with(@device) do |format|
      format.html{ redirect_to devices_url }
    end
  end
end
