require 'booking_repository'
require 'booking'
def reset_tables
    seed_sql = File.read('spec/seeds_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end
   describe BookingRepository do
      before(:each) do
          reset_bookings_tables
      end
    end
 
RSpec.describe BookingRepository do
  context 'to test the all method it'    
    it 'returns a list of bookings' do
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

    
   

end


 