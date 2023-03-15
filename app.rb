require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/property_repository'
require_relative 'lib/customer_repository'
require_relative 'lib/owner_repository'

DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/space/all' do
    repo = PropertyRepository.new
    @all_spaces = repo.all
    return erb(:all_spaces)
  end

  get '/space/form' do
    return erb(:property_form)
  end

  post '/space/form' do
    if invalid_request_parameters_property?
      status 400
      return ''
    end

    new_property = Property.new
    new_property.property_name = params[:property_name]
    new_property.property_description = params[:property_description]
    new_property.property_price = params[:property_price]
    new_property.property_avail_date = params[:property_avail_date]
    new_property.property_status = params[:property_status]
    new_property.owner_id = params[:owner_id]
    repo = PropertyRepository.new
    repo.create(new_property)
    return erb(:confirmation_page_property)
  end

  def invalid_request_parameters_property?
    return true if params[:property_name] == nil || params[:property_description] == nil || params[:property_status] == nil
    return true if params[:property_name] == "" || params[:property_description] ==  "" || params[:property_status] == ""  
    return false
  end

  # Route blocks for the sign up process

  get "/sign_in" do
    return erb(:sign_in)
  end

  get "/sign_up/customer" do
    return erb(:sign_up_customer)
  end

  get "/sign_up/owner" do
    return erb(:sign_up_owner)
  end

  post "/sign_up/customer" do
    repo = CustomerRepository.new
    new_customer = Customer.new
    new_customer.customer_name = params[:customer_name]
    new_customer.customer_email = params[:customer_email]
    customers = repo.all
    customers.each do |record|
      if record.customer_name == new_customer.customer_name
        return "That customer name exists already! Choose a different name"
      elsif record.customer_email == new_customer.customer_email
        return "That email address exists already! Choose a different email"  
      end
    end
    repo.create(new_customer)
    return erb(:successful_account_creation)
  end

  post "/sign_up/owner" do
    repo = OwnerRepository.new
    new_owner = Owner.new
    new_owner.owner_name = params[:owner_name]
    new_owner.owner_email = params[:owner_email]
    owners = repo.all
    owners.each do |record|
      if record.owner_name == new_owner.owner_name
        return "That owner name exists already! Choose a different name"
      elsif record.owner_email == new_owner.owner_email
        return "That email address exists already! Choose a different email"  
      end
    end
    repo.create(new_owner)
    return erb(:successful_account_creation)
  end

end