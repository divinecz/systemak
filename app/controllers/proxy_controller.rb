class ProxyController < ApplicationController

  def show
    @device = Device.find_by_param!(params[:device_id])
    query = params[:query] || {}
    file = params[:file]
    respond_to do |format|
      format.json do
        if file.nil? || (data = @device.read_raw(file, query)) == false
          render :nothing => true, :status => :forbidden
        else
          render :json => { :data => data }
        end
      end
    end
  end

  def update
    #TODO
  end

end
