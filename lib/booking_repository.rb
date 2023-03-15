class BookingRepository
  def all
   query = "SELECT * FROM bookings;"
   result_set = DatabaseConnection.exec_params(query, [])
   bookings = []
   result_set.each do |record|
    booking = Booking.new
    booking.id = record["id"].to_i
    booking.booking_date = record["booking_date"]
    booking.booking_status = record["booking_status"]
    booking.property_id = record["property_id"].to_i
    booking.customer_id = record["customer_id"].to_i
    bookings.push(booking)
   end
   return bookings
  end

  def find(id)
    sql = 'SELECT id, booking_date, booking_status, property_id, customer_id FROM bookings WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql,[id])
    booking = Booking.new
    booking.id = result_set[0]['id'].to_i
    booking.booking_date = result_set[0]['booking_date']
    booking.booking_status = result_set[0]['booking_status']
    booking.property_id = result_set[0]['property_id'].to_i
    booking.customer_id = result_set[0]['customer_id'].to_i
    return booking
  end
  def create(booking)
    sql = 'INSERT INTO bookings (booking_date, booking_status, property_id, customer_id) VALUES ($1, $2, $3, $4);'
    result_set = DatabaseConnection.exec_params(sql, [booking.booking_date, booking.booking_status, booking.property_id, booking.customer_id])

  end
end