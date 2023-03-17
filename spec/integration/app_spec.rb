require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'
require_relative '../../lib/customer_repository'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_tables
    seed_sql = File.read('spec/seeds_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_tables
  end

  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
    end
  end

  context 'GET /space/all' do
    it 'Displays all available spaces.' do
      response = get('/space/all')

      expect(response.status).to eq(200)
      expect(response.body).to include 'Lake View'
    end
  end

  context 'GET /space/form' do
    it "Returns the form." do
      response = get('/space/form')
      expect(response.status).to eq 200
      expect(response.body).to include '<form action="/space/form" method="POST">'
    end
  end

  context 'POST /space/form' do
    it "Lists a space and returns the confirmation message." do
      response = post('/space/form', property_name: 'Mason Manor', property_description: '4 bedroom house', property_price: 250, property_avail_date: '2023-04-17', property_status: 'available', owner_id: 2)
      expect(response.status).to eq 200
      expect(response.body).to include '<title>Confirmed!</title>'
    end
  end

  context 'GET /sign_up' do
    it "displays the sign in page" do
      response = get("/sign_in")

      expect(response.status).to eq 200
      expect(response.body).to include 'Sign up as a customer'
      expect(response.body).to include 'Sign up as an owner'
    end
  end

  context "GET /sign_up/customer" do
    it "displays the sign up page for customers" do
      response = get('/sign_up/customer')

      expect(response.status).to eq 200
      expect(response.body).to include '<input id="customer_name" type="text" name="customer_name" required><br><br>'
    end
  end

  context "GET /sign_up/owner" do
    it "displays the sign up page for owners" do
      response = get('/sign_up/owner')

      expect(response.status).to eq 200
      expect(response.body).to include '<form method="POST" action="/sign_up/owner">'
    end
  end

  context "/sign_up/customer" do
    it "creates a new customer and displays a success page" do
      repo = CustomerRepository.new
      response = post("/sign_up/customer", customer_name: "Francesco", customer_email: "jiggles@example.com")
      customers = repo.all

      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Account created successfully!</h1><br><br>'
      expect(customers.length).to eq 5
      expect(customers.last.customer_name).to eq 'Francesco'
      expect(customers.last.customer_email).to eq "jiggles@example.com"
    end

    it "displays an unsuccess page if one of the details inputted exists already" do  
      response = post("/sign_up/customer", customer_name: "Francesco", customer_email: "customer1@example.com")

      expect(response.status).to eq 200
      expect(response.body).to include 'That email address exists already! Choose a different email'

      response = post("/sign_up/customer", customer_name: "Customer 1", customer_email: "jiggles@example.com")

      expect(response.status).to eq 200
      expect(response.body).to include 'That customer name exists already! Choose a different name'
    end
  end

  context 'GET space/edit/' do
    it "Returns the form to update a space with ID 2." do
      response = get('/space/edit?id=2')
      expect(response.status).to eq 200
      expect(response.body).to include '<form action="/space/edit" method="POST">'
    end
  end

  context 'POST space/edit' do
    it "Updates price for a space with ID 2 and redirects to the updated space page." do
      response = post('/space/edit', id: 2, property_price: 90)
      expect(response.status).to eq 302
      expect(response).to be_redirect
    end

    it "Updates description for a space with ID 2 and redirects to the updated space page." do
      response = post('/space/edit', id: 2, property_description: 'Two large bedroom flat')
      expect(response.status).to eq 302
      expect(response).to be_redirect
    end
  end

  context "returns specifc property page" do
    it "returns page for property 1" do
      response = get('space?id=1')
      expect(response.status).to eq(200)
      expect(response.body).to include '<h1>Property 1</h1>'
    end
  end

  context "returns specifc property page" do
    it "returns page for property 2" do
      response = get('space?id=2')
      expect(response.status).to eq(200)
      expect(response.body).to include '<h1>Property 2</h1>'
    end
  end

    context "GET /space/dates" do
      it "lists all dates for property1 " do
        response = get('/space?id=1')
        expect(response.status).to eq 200
        expect(response.body).to include  '<p>["2023-04-01", "2023-04-07", "2023-04-09"]</p>'
      end
      it "lists all dates for property2 " do
        response = get('/space?id=2')
        expect(response.status).to eq 200
        expect(response.body).to include  '<p>["2023-04-02", "2023-04-09", "2023-04-14"]</p>' 
      end
      it "lists all dates for property3 " do
        response = get('/space?id=3')
        expect(response.status).to eq 200
        expect(response.body).to include   '<p>["2023-04-23", "2023-04-24", "2023-04-25"]</p>'  
      end
      
    end 
   
end
