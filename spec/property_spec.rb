require 'property_repository'
require 'property_model'

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
      expect(properties[0].property_name).to eq 'Property 1'
      expect(properties[1].property_name).to eq 'Property 2'
      expect(properties.last.property_price).to eq 35.0
    end

    it "Returns a specific property." do
      repo = PropertyRepository.new
      properties = repo.all
      property = repo.find(2)
      expect(property.property_name).to eq 'Property 2'
    end

    it "Creates a new property." do
      repo = PropertyRepository.new
      properties = repo.all
      new_property = Property.new
      new_property.property_name = 'Wogan House'
      new_property.property_description = '20 rooms available'
      new_property.property_price = 1500
      new_property.property_avail_date = '2023-03-20'
      new_property.property_status = 'Available'
      new_property.owner_id = 1
      repo.create(new_property)
      properties = repo.all
      latest_property = repo.find(4)
      expect(properties.length).to eq 4
      expect(latest_property.property_name).to eq "Wogan House"
    end

    it "Deletes a property." do
      repo = PropertyRepository.new
      properties = repo.all
      new_property1 = Property.new
      new_property1.property_name = 'Wogan House'
      new_property1.property_description = '20 rooms available'
      new_property1.property_price = 1500
      new_property1.property_avail_date = '2023-03-20'
      new_property1.property_status = 'Available'
      new_property1.owner_id = 1
      repo.create(new_property1)

      new_property2 = Property.new
      new_property2.property_name = 'Harris Manor'
      new_property2.property_description = '4 rooms available'
      new_property2.property_price = 350
      new_property2.property_avail_date = '2023-03-22'
      new_property2.property_status = 'Available'
      new_property2.owner_id = 2
      repo.create(new_property2)

      repo.delete(4)
      properties = repo.all
      expect(properties.length).to eq 4
      expect(properties.last.property_price).to eq 350

    end

    it "Updates a property." do
      repo = PropertyRepository.new
      #properties = repo.all
      match = repo.find(3)
      expect(match.property_description).to include 'Three bedroom'
    end
  end
end