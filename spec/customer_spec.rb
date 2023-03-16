require "customer_repository"

describe CustomerRepository do

  def reset_tables
    seed_sql = File.read('spec/seeds_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_tables
  end

  context "all method" do
    it "returns a list of customers" do
      repo = CustomerRepository.new
      customers = repo.all

      expect(customers.length).to eq 4
      expect(customers[0].id).to eq 1
      expect(customers[0].customer_name).to eq "Customer 1"
      expect(customers[0].customer_email).to eq "customer1@example.com"
      expect(customers[0].customer_password).to eq "Styrofoam98"
      expect(customers[-1].id).to eq 4
      expect(customers[-1].customer_name).to eq "Customer 4"
      expect(customers[-1].customer_email).to eq "customer4@example.com"
      expect(customers[-1].customer_password).to eq "Giggidy69"
    end
  end

  context "find method" do
    it "throws an error if id (argument) is not an Integer" do
      repo = CustomerRepository.new

      expect{ repo.find("hello") }.to raise_error "ID has to be an Integer!"
    end
  
    it "returns a specific customer by ID" do
      repo = CustomerRepository.new
      customer = repo.find(1)

      expect(customer.length).to eq 1
      expect(customer[0].id).to eq 1
      expect(customer[0].customer_name).to eq "Customer 1"
      expect(customer[0].customer_email).to eq "customer1@example.com"
      expect(customer[0].customer_password).to eq "Styrofoam98"
    end
  end

  context "create method" do 
    it "throws an error if new_customer is not an instance of Customer" do
      repo = CustomerRepository.new

      expect{ repo.create(8) }.to raise_error "new-customer has to be an instance of Customer!"
    end

    it "creates a new customer, returns nothing" do
      repo = CustomerRepository.new
      new_customer = Customer.new
      new_customer.customer_name = "Customer 5"
      new_customer.customer_email = "customer5@example.com"
      new_customer.customer_password = "Muppet54"
      repo.create(new_customer)
      customers = repo.all

      expect(customers.length).to eq 5
      expect(customers[-1].id).to eq 5
      expect(customers[-1].customer_name).to eq "Customer 5"
      expect(customers[-1].customer_email).to eq "customer5@example.com"
      expect(customers[-1].customer_password).to eq "Muppet54"
    end
  end

  context "delete method" do
    it "throws an error if id is not an integer" do
      repo = CustomerRepository.new

      expect{ repo.delete("hello") }.to raise_error "ID has to be an Integer!"
    end

    it "deletes a customer, returns nothing" do
      repo = CustomerRepository.new
      repo.delete(1)
      customers = repo.all

      expect(customers.length).to eq 3
      expect(customers[0].id).to eq 2
      expect(customers[0].customer_name).to eq "Customer 2"
      expect(customers[0].customer_email).to eq "customer2@example.com"
      expect(customers[0].customer_password). to eq "Decapitate12"
    end
  end

  context "update method" do
    it "throws an error if customer is not an instance of Customer" do
      repo = CustomerRepository.new

      expect{ repo.update("hello") }.to raise_error "customer has to be an instance of Customer!"
    end

    it "updates the customer attributes, returns nothing" do
      repo = CustomerRepository.new
      customer = repo.find(4)[0]
      customer.customer_name = "Johnny Depp"
      customer.customer_email = "star@gmail.com"
      customer.customer_password = "Ganglion42"
      repo.update(customer)
      customers = repo.all

      expect(customers.length).to eq 4
      expect(customers[-1].id).to eq 4
      expect(customers[-1].customer_name).to eq "Johnny Depp"
      expect(customers[-1].customer_email).to eq "star@gmail.com"
      expect(customers[-1].customer_password).to eq "Ganglion42"
    end
  end

end

