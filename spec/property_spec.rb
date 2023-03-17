require 'property_repository'

def reset_properties_table
  seed_sql = File.read('spec/seeds_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

RSpec.describe PropertyRepository do
  before(:each)do
    reset_properties_table
  end
  context "When at least one property." do
    it "Returns all properties." do
      repo = PropertyRepository.new
      properties = repo.all
      expect(properties[0].property_name).to eq 'The Old Loft'
      expect(properties[1].property_name).to eq 'Lake View'
      expect(properties.last.property_price).to eq 35.0
    end

    it "Returns a specific property." do
      repo = PropertyRepository.new
      properties = repo.all
      property = repo.find(2)
      expect(property.property_name).to eq 'Lake View'
    end

    it "Creates a new property." do
      repo = PropertyRepository.new
      properties = repo.all
      new_space = Property.new
      new_space.property_name = 'Wogan House'
      new_space.property_description = '20 rooms available'
      new_space.property_price = 1500
      new_space.property_avail_date = '2023-03-20'
      new_space.property_status = 'Available'
      new_space.owner_id = 1
      repo.create(new_space)
      properties = repo.all
      latest_property = repo.find(4)
      expect(properties.length).to eq 4
      expect(latest_property.property_name).to eq "Wogan House"
    end

    it "Deletes a property." do
      repo = PropertyRepository.new
      properties = repo.all
      new_space1 = Property.new
      new_space1.property_name = 'Wogan House'
      new_space1.property_description = '20 rooms available'
      new_space1.property_price = 1500
      new_space1.property_avail_date = '2023-03-20'
      new_space1.property_status = 'Available'
      new_space1.owner_id = 1
      repo.create(new_space1)

      new_space2 = Property.new
      new_space2.property_name = 'Harris Manor'
      new_space2.property_description = '4 rooms available'
      new_space2.property_price = 350
      new_space2.property_avail_date = '2023-03-22'
      new_space2.property_status = 'Available'
      new_space2.owner_id = 2
      repo.create(new_space2)

      repo.delete(4)
      properties = repo.all
      expect(properties.length).to eq 4
      expect(properties.last.property_price).to eq 350

    end

    it "Updates a property." do
      repo = PropertyRepository.new
      match = repo.find(3)
      expect(match.property_description).to include 'Three bedroom'
    end
  end
end