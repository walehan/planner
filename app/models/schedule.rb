class Schedule < ActiveRecord::Base
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :user_id, presence: true

  def event_overlaps_scheduled_events?(new_event)
    # At some point, we're going to need to do this all in SQL as doing it in the ORM will get too expensive

    # This is probably an inefficient/terrible way to do it, but I'm doing this quickly/will optimize later
    # Steps:
    #   Get all event start/end times
    #   Directly compare new evnt times with each event time (linear)
    #   Probably good enough since there won't be a bazillion events to compare to
    self.events.each do |x|
      if x != new_event 
        return true if ((new_event.start_time < x.end_time) and (x.start_time < new_event.end_time))
      end 
    end
    return false
  end

end
