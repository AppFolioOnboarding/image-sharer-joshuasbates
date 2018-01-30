require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'root route responds successfully' do
    get root_path
    assert_response :ok
    assert_select 'h1', 'Welcome!'
  end
end
