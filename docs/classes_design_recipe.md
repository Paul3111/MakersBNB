# List of the classes

**Model classes:**

Customer 
path: (/lib/customer_model.rb)

Owner 
path: (/lib/owner_model.rb)

Booking 
path: (/lib/booking_model.rb)

Property 
path: (/lib/property_model.rb)

**Repository classes:**

CustomerRepository (lib/customer_repository.rb)

OwnerRepository (lib/owner_repository.rb)

BookingRepository (lib/booking_repository.rb)

PropertyRepository (lib/property_repository.rb)

# Implementation of the Model classes

```ruby

# customer_model.rb

class Customer
  attr_accessor :id, :customer_name, :customer_email
end

# owner_model.rb

class Owner
  attr_accessor :id, :owner_name, :owner_email
end

# booking_model.rb

class Booking
  attr_accessor :id, :booking_date, :booking_status, :property_id, :customer_id, 
end

# property_model.rb

class Property
  attr_accessor :id, :property_name, :property_description, :property_price, :property_avail_date, :property_status, :owner_id
end

```

# Designing the Repository classes signature

## All methods send a query to the database

```ruby

# (lib/customer_repository.rb)

class CustomerRepository

  def all
    # it returns a list of customers
  end

  def find(id) # id has to be an integer
    # it returns a specific customer by ID
  end

  def create(new_customer) # new_customer is an instance of Customer
    # it creates a new customer, returns nothing
  end

  def delete(id) # id has to be an integer
    # it deletes a customer, returns nothing
  end

  def update(customer) # customer is an instance of Customer
    # it updates the customer attributes, returns nothing
  end

end


# (lib/owner_repository.rb)

class OwnerRepository

  def all
    # it returns a list of owners
  end

  def find(id) # id has to be an integer
    # it returns a specific owner by ID
  end

  def create(new_owner) # new_customer is an instance of Owner
    # it creates a new owner, returns nothing
  end

  def delete(id) # id has to be an integer
    # it deletes a owner, returns nothing
  end

  def update(owner) # owner is an instance of Owner
    # it updates the customer attributes, returns nothing
  end

end

# (lib/booking_repository.rb)

class BookingRepository

  def all
    # it returns a list of bookings
  end

  def find(id) # id has to be an integer
    # it returns a specific booking by ID
  end

  def create(new_booking) # new_booking is an instance of Booking
    # it creates a new booking, returns nothing
  end

  def delete(id) # id has to be an integer
    # it deletes a booking, returns nothing
  end

  def update(booking)
    # it updates the booking attributes, returns nothing
  end

end

# (lib/property_repository.rb)

class PropertyRepository

  def all
    # it returns a list of properties
  end

  def find(id) # id has to be an integer
    # it returns a specific property by ID
  end

  def create(new_property) # new_property is an instance of Property
    # it creates a new property, returns nothing
  end

  def delete(id) # id has to be an integer
    # it deletes a property, returns nothing
  end

  def update(property) # property is an instance of Property
    # it updates the property attributes, returns nothing
  end

end

```

# Test Examples for CustomerRepository


```ruby

# 1. it returns a list of customers

repo = CustomerRepository.new
customers = repo.all

expect(customers.length).to eq 4
expect(customers[0].id).to eq 1
expect(customers[0].customer_name).to eq "Customer 1"
expect(customers[0].customer_email).to eq "customer1@test.com"
expect(customers[-1].id).to eq 4
expect(customers[-1].customer_name).to eq "Customer 4"
expect(customers[-1].customer_email).to eq "customer4@test.com"

```