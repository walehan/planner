require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  # Add test requiring user_id

  test "schedule saves with required fields" do
    schedule = Schedule.new

    schedule.user_id = nil
    schedule.name = "test name"
    assert_not schedule.save, "Should not save without user_id"

    schedule.name = nil
    schedule.user_id = 1
    assert_not schedule.save, "Should not save without user name"

    schedule.user_id = 1
    schedule.name = "test name"
    assert schedule.save, "Schedule should save with name and user_id defined"
  end

  test "correctly return if time ranges overlap" do
    schedule = Schedule.new(user_id: 1, name: "test name")
    test_event = Event.new(name: 'test event',
                        start_time: '2014-01-01 1:30:00',
                        end_time: '2014-01-01 2:00:00',
                        address: '123 test address',
                        city: 'Test city',
                        state: 'test state',
                        zip_code: '12345')
    assert_not schedule.event_overlaps_scheduled_events?(test_event), 
            "Events should not be marked as overlapping when there is no events defined"

    schedule_event = schedule.events.new(name: 'schedule event 1',
                        start_time: '2014-01-01 2:30:00',
                        end_time: '2014-01-01 3:30:00',
                        address: '123 test address',
                        city: 'Test city',
                        state: 'test state',
                        zip_code: '12345')
    assert_not schedule.event_overlaps_scheduled_events?(test_event), 
            "Events should not be marked as overlapping"


    test_event.start_time = '2014-01-01 2:45'
    test_event.end_time = '2014-01-01 4:00'
    assert schedule.event_overlaps_scheduled_events?(test_event), "Start time should be within overlapping time range"

    test_event.start_time = '2014-01-01 2:15'
    test_event.end_time = '2014-01-01 3:00'
    assert schedule.event_overlaps_scheduled_events?(test_event), "End time should be within overlapping time range"

    test_event.start_time = '2014-01-01 2:15'
    test_event.end_time = '2014-01-01 3:00'
    assert schedule.event_overlaps_scheduled_events?(test_event), "Both start and end time should be overlapping" 

    test_event.start_time = '2014-01-01 2:30'
    test_event.end_time = '2014-01-01 3:30'
    assert schedule.event_overlaps_scheduled_events?(test_event), "Start and end time are same, should be overlapping"

  end

end
