require 'test_helper'

class Admin::PatientsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_patients_new_url
    assert_response :success
  end

end
