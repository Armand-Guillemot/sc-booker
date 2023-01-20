json.extract! reservation, :id, :start_date, :end_date, :user_id, :property_id, :guest_count, :comment, :status, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
