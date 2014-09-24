require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  setup do
    @schedule = Schedule.new(name: "original name", user_id: 10) 
    @schedule.save
    @controller = Api::V1::SchedulesController.new
  end

  test "should get index" do
    # When adding user auth, validate that only relevant schedules are returned
    get :index
    assert_response :success
    assert_not_nil assigns(:schedules)
  end

  test "should create schedule" do
    assert_difference('Schedule.count') do
      post :create, {:format => 'json', :schedule => {:name => "test_name", :user_id => 1}}
    end

    @new_schedule = Schedule.find_by name: "test_name", user_id: 1
    assert @new_schedule, "New schedule should have been created on post"

    assert_response 201
  end

  test "should show schedule" do
    # When adding user auth, validate that only relevant schedules are returned
    get :show, id: @schedule.id
    assert_response :success
    assert assigns(:schedule) == @schedule 

    # Need a better way to do this other than id+1
    get :show, id: @schedule.id+1 
    assert_response :success
    assert assigns(:schedule).nil?, "Should return nil for invalid id"

  end

  test "should update schedule" do
    # When adding user auth, validate that only relevant schedules are updated 
    put :update, id: @schedule, schedule: {name: "test update" }
    @schedule.reload
    assert @schedule.name == "test update", "Schedule name should be updated to 'test update'"
    assert_response 204
  end

  test "should destroy schedule" do
    # When adding user auth, validate that only relevant schedules are deleted 
    assert_difference('Schedule.count', -1) do
      delete :destroy, id: @schedule
    end

    assert_response 204
  end
end
