require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

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
      expect(response.body).to include 'Property 2'
    end
  end

    context 'GET /space/form' do
      it "Returns the form." do
        response = get('/space/form')
        expect(response.status).to eq 200
        expect(response.body).to include '<input type="submit" value="Submit the form">'
      end
    end

    context 'POST /space/form' do
      it "Lists a space and returns the confirmation message." do
        response = post('/space/form', property_name: 'Mason Manor', property_description: '4 bedrooms house', property_price: 250, property_avail_date: '2023-04-17', property_status: 'available', owner_id: 2)
        expect(response.status).to eq 200
        expect(response.body).to include '<title>Confirmed!</title>'
      end
    end

  context 'GET space/edit/' do # Paul
    it "Returns the form to update a space with ID 2." do
      response = get('/space/edit?id=2')
      expect(response.status).to eq 200
      expect(response.body).to include '<input type="text" name="property_name" placeholder="Property name"><br>'
    end
  end

  context 'POST space/edit' do # Paul
    it "Updates a space with ID 2 and redirects to the updated space page." do
      response = post('/space/edit',
      id: 2,
      property_name: 'Property 2',
      property_description: 'Two large bedroom flat',
      property_price: 90
      )
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
      it "lists all dates for property 1 " do
        response = get('/space?id=1')
        expect(response.status).to eq 200
        expect(response.body).to include  '<p>["2023-04-01", "2023-04-07", "2023-04-09"]</p>'
      end
      it "lists all dates for property 2 " do
        response = get('/space?id=2')
        expect(response.status).to eq 200
        expect(response.body).to include  '<p>["2023-04-02", "2023-04-09", "2023-04-14"]</p>' 
      end
      it "lists all dates for property 3 " do
        response = get('/space?id=3')
        expect(response.status).to eq 200
        expect(response.body).to include   '<p>["2023-04-23", "2023-04-24", "2023-04-25"]</p>'  
      end
      
    end 
   
end
