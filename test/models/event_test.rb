require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "events should have required fields" do
    schedule = Schedule.new(name: 'test name', user_id: 1)
    event = schedule.events.new(name: 'test event 1',
                        start_time: '2014-02-01 11:00:00',
                        end_time: '2014-02-01 21:00:00',
                        address: '123 test address',
                        city: 'Test city',
                        state: 'test state',
                        zip_code: '12345')
    assert event.valid?, event.errors.full_messages.inspect
    
    event.name = nil
    assert_not event.valid?, "Name must be populated" 

    event.name = "test name"
    event.start_time = nil
    assert_not event.valid?, "Start time must be populated"

    event.start_time = '2014-01-01 1:00:00'
    event.end_time = nil
    assert_not event.valid?, "End time must be populated"

    event.end_time = '2014-01-01 2:00:00'
    event.address = nil
    event.city = nil
    event.state = nil
    event.zip_code = nil
    assert_not event.valid?, "Either address or lat/long must be populated"

    event.latitude = 1.0
    event.longitude = 1.0
    assert event.valid?, event.errors.full_messages.inspect

  end

#  test "events should not overlap on creation" do
#    schedule = Schedule.new(name: 'test name', user_id: 1)
#    event1 = schedule.events.new(name: 'test event 1',
#                        start_time: '2014-01-01 1:00:00',
#                        end_time: '2014-01-01 2:00:00',
#                        address: '123 test address',
#                        city: 'Test city',
#                        state: 'test state',
#                        zip_code: '12345')
#    event2 = schedule.events.new(name: 'test event 2',
#                        start_time: '2014-01-01 2:30:00',
#                        end_time: '2014-01-01 3:30:00',
#                        address: '123 test address',
#                        city: 'Test city',
#                        state: 'test state',
#                        zip_code: '12345')
#    event3 = schedule.events.new(name: 'test event 2',
#                        start_time: '2014-01-01 1:30:00',
#                        end_time: '2014-01-01 2:00:00',
#                        address: '123 test address',
#                        city: 'Test city',
#                        state: 'test state',
#                        zip_code: '12345')
#    assert_not schedule.save, "Event times cannot overlap"
#
#    event3.start_time = '2014-01-01 2:00:00'
#    event3.end_time = '2014-01-01 2:15:00'
#    assert schedule.save, "Event times save fine with no overlap"
#
#    event2.start_time = '2014-01-01 1:30'
#    assert_not event2.save, "Event time cannot be updated to overlap"
#  end
end
