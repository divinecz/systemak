require 'test_helper'

class LogsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Log.first
    assert_template 'show'
  end
  
  def test_destroy
    log = Log.first
    delete :destroy, :id => log
    assert_redirected_to logs_url
    assert !Log.exists?(log.id)
  end
end
