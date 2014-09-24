class Event < ActiveRecord::Base
  belongs_to :schedule
  validates_presence_of :schedule

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :address_or_location_must_be_specified
  # validate :event_does_not_overlap_with_scheduled_events

  # validation methods
  def address_or_location_must_be_specified
    if (address.nil? && state.nil? && zip_code.nil? && city.nil?) && (latitude.nil? && longitude.nil?)
      errors[:base] << "Either address fields or latitude/longitude fields must be populated"
    end
  end

  def event_does_not_overlap_with_scheduled_events
    if self.schedule.event_overlaps_scheduled_events?(self)
      errors[:base] << "New event overlaps with defined events on schedule"
    end
  end
end
