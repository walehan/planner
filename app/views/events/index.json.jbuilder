json.array!(@events) do |event|
  json.extract! event, :id, :name, :start_time, :end_time, :address, :city, :state, :zip_code, :latitude, :longitude, :schedule_id
  json.url event_url(event, format: :json)
end
