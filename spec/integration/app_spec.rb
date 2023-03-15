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

  context 'GET spaces/:id/edit' do
    it "Returns the form to update a space." do
      response = get('/space/2/edit')
      expect(response.status).to eq 200
      expect(response.body).to include '<input type="text" name="property_name" placeholder="Property name" required><br>'
    end
  end

  context 'POST spaces/:id/edit' do
    it "Updates a space and redirects to the confirmation page." do
      response = post('/space/2/edit',
      property_description: 'Two large bedroom flat',
      property_price: 90,
      owner_id: 2,
      )
      expect(response.status).to eq 200
      expect(response.body).to include 'Property 2'
      expect(response.body).to include 'Two large bedrom flat'
      expect(response.body).to include '90'
    end
  end
end
