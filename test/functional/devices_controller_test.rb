require 'test_helper'

class DevicesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Device.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Device.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Device.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to device_url(assigns(:device))
  end
  
  def test_edit
    get :edit, :id => Device.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Device.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Device.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Device.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Device.first
    assert_redirected_to device_url(assigns(:device))
  end
  
  def test_destroy
    device = Device.first
    delete :destroy, :id => device
    assert_redirected_to devices_url
    assert !Device.exists?(device.id)
  end
end
