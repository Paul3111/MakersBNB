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

# 2. id has to be an integer

repo = CustomerRepository.new

expect{ repo.find("hello") }.to raise_error "ID has to be an Integer!"

# 3. it returns a specific customer by ID

repo = CustomerRepository.new
customer = repo.find(1)

expect(customer.length).to eq 1
expect(customer[0].id).to eq 1
expect(customer[0].customer_name).to eq "Customer 1"
expect(customer[0].customer_email).to eq "customer1@test.com"

# 4. new_customer is an instance of Customer

repo = CustomerRepository.new

expect{ repo.create(8) }.to raise_error "new-customer has to be an instance of Customer!"

# 5. it creates a new customer, returns nothing

repo = CustomerRepository.new
new_customer = Customer.new
new_customer.customer_name = "Customer 5"
new_customer.customer_email = "customer5@test.com"
repo.create(new_customer)
customers = repo.all

expect(customers.length).to eq 5
expect(customers[-1].id).to eq 5
expect(customers[-1].customer_name).to eq "Customer 5"
expect(customers[-1].customers_email).to eq "customer5@test.com"

# 6. id has to be an integer

repo = CustomerRepository.new

expect{ repo.delete("hi mom") }.to raise_error "ID has to be an Integer!"

# 7. it deletes a customer, returns nothing

repo = CustomerRepository.new
repo.delete(1)
customers = repo.all

expect(customers.length).to eq 3
expect(customers[0].id).to eq 2
expect(customers[0].customer_name).to eq "Customer 2"
expect(customers[0].customer_email).to eq "customer2@test.com"

# 8. customer is an instance of Customer

repo = CustomerRepository.new

expect{ repo.update("hello") }.to raise_error "customer has to be an instance of Customer!"

# 9. it updates the customer attributes, returns nothing

repo = CustomerRepository.new
customer = repo.find(4)[0]
customer.customer_name = "Johnny Depp"
customer.customer_email = "star@gmail.com"
repo.update(customer)
customers = repo.all

expect(customers.length).to eq 4
expect(customers[-1].id).to eq 4
expect(customers[-1].customer_name).to eq "Johnny Depp"
expect(customers[-1].customer_email).to eq "star@gmail.com"


```