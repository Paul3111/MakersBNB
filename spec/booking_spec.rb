require 'booking_repository'
require 'booking'
def reset_tables
    seed_sql = File.read('spec/seeds_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end
  
RSpec.describe BookingRepository do
    before(:each) do
        reset_tables
    end
  context 'to test the all method it'    
    it 'returns all bookings' do
        repo = BookingRepository.new
        bookings = repo.all
        expect(bookings.length).to eq(5)
        expect(bookings[0].id).to eq(1)
        expect(bookings[0].booking_date).to eq("2023-04-01")
        expect(bookings[0].booking_status).to eq("pending")
        expect(bookings[0].property_id).to eq(1)
        expect(bookings[0].customer_id).to eq(1)
    end
    context 'to test the find method' do
        it 'should return the booking where the id is 3' do
            repo = BookingRepository.new
            booked = repo.find(3)
            expect(booked.id).to eq(3)
            expect(booked.booking_date).to eq("2023-04-01")
            expect(booked.booking_status).to eq("rejected")
        end
    end
    context 'test create method' do
        it "should show the new booking" do
            repo = BookingRepository.new
            new_booking = Booking.new
            new_booking.booking_date = '2023-07-14'
            new_booking.booking_status = 'pending'
            new_booking.property_id = 3
            new_booking.customer_id = 3
            repo.create(new_booking)
            all_booking = repo.all
            expect(all_booking.last.id).to eq(6)
            expect(all_booking.last.booking_date).to eq("2023-07-14")
        end
    end

    
   

end


 