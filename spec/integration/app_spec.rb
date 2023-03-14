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

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.


  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
    end
  end

  context 'GET /space/new' do
    it "Returns the form." do
      response = get('/space/new')
      expect(response.status).to eq 200
      expect(response.body).to include '<input type="submit" value="Submit the form">'
    end
  end

  context 'POST /space' do
    it "Lists a space and returns the confirmation message." do
      response = post('/space',
      property_name: 'Mason Manor',
      property_description: '4 bedrooms house',
      property_price: 250,
      property_avail_date: '2023-04-17',
      property_status: 'Available',
      owner_id: 2
    )
      expect(response.status).to eq 200
      expect(response.body).to include 'Mason Manor'
    end
  end
end
