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
    return erb(:sign_in) if @current_user_id.nil?
    return erb(:index)
  end

  get '/space/all' do
    repo = PropertyRepository.new
    @all_spaces = repo.all
    @images = ["https://www.pettyson.co.uk/images/blog_posts/different-types-of-property/block_of_flats.jpg", "https://media.product.which.co.uk/prod/images/original/gm-559b247c-6c97-4692-85be-0a32e2a811e0-istock-123727292-1.jpeg", "https://www.propertypriceadvice.co.uk/wp-content/uploads/2016/06/Flats.jpg", "https://upload.wikimedia.org/wikipedia/commons/2/26/Noel_Park_cottage_flats.JPG", "https://wp.inews.co.uk/wp-content/uploads/2018/02/houses.jpg", "https://q-xx.bstatic.com/xdata/images/hotel/max1024x768/48373839.jpg?k=9648094f5fee8c2cbf00c099d6aacc9f0a09a8a92f0bf778219af5f8f9dd5002&o="]
    return erb(:all_spaces)
  end

  get '/space/edit' do # Gets the form to edit the space
    return "You don't have the authorization to edit properties." if @current_user_status
    return erb(:edit_space_form)
  end

  post '/space/edit' do # Updates selected space
    repo = PropertyRepository.new
    id = params[:id]
    property_name = params[:property_name]
    property_description = params[:property_description]
    property_price = params[:property_price]

    selected_space = repo.find(id)
    property_name ? selected_space.property_name = property_name : selected_space.property_name = property_name = ""
    property_description ? selected_space.property_description = property_description : selected_space.property_description = ""
    property_price ? selected_space.property_price = property_price : selected_space.property_price = ""
    repo.update(selected_space)
    redirect "/space?id=#{id}"
  end

  get '/space/form' do # This is used when an owner lists a property
    return erb(:property_form)
  end

  get '/space' do
    @dates = [["2023-04-01","2023-04-07","2023-04-09"], ["2023-04-02","2023-04-09","2023-04-14"], ["2023-04-23","2023-04-24","2023-04-25"]]
    @images = ["https://www.pettyson.co.uk/images/blog_posts/different-types-of-property/block_of_flats.jpg", "https://media.product.which.co.uk/prod/images/original/gm-559b247c-6c97-4692-85be-0a32e2a811e0-istock-123727292-1.jpeg", "https://www.propertypriceadvice.co.uk/wp-content/uploads/2016/06/Flats.jpg", "https://upload.wikimedia.org/wikipedia/commons/2/26/Noel_Park_cottage_flats.JPG", "https://wp.inews.co.uk/wp-content/uploads/2018/02/houses.jpg", "https://q-xx.bstatic.com/xdata/images/hotel/max1024x768/48373839.jpg?k=9648094f5fee8c2cbf00c099d6aacc9f0a09a8a92f0bf778219af5f8f9dd5002&o="]
    repo = PropertyRepository.new
    space = repo.find(params[:id])
    @space_name = space.property_name
    @space_description = space.property_description
    @space_price = space.property_price
    return erb(:specific_space)
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
    new_customer.customer_password = params[:customer_password]
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
    new_owner.owner_password = params[:owner_password]
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

  # Route blocks for the sign in process

  def current_user_details
    @current_user_id = nil
    @current_user_status = nil
  end

  get "/log_in/customer" do
    return erb(:log_in_customer)
  end

  get "/log_in/owner" do
    return erb(:log_in_owner)
  end

  post "/log_in/customer" do
    repo = CustomerRepository.new
    customers = repo.all
    customers.each do |customer_record|
      if customer_record.customer_name == params['customer_name']
        if customer_record.customer_email == params['customer_email']
          if customer_record.customer_password == params['customer_password']
            @current_user_id = customer_record.id
            @current_user_status = "customer"
            return erb(:index)
          else
            @current_user_id = nil
            return "Password is not correct! Try again."
          end
        else
          @current_user_id = nil
          return "Email is not correct! Try again."
        end
      else
        @current_user_id = nil
        return "Name is not correct! Try again."
      end
    end
  end

  post "/log_in/owner" do
    repo = OwnerRepository.new
    owners = repo.all
    owners.each do |owner_record|
      if owner_record.owner_name == params['owner_name']
        if owner_record.owner_email == params['owner_email']
          if owner_record.owner_password == params['owner_password']
            @current_user_id = owner_record.id
            @current_user_status = "owner"
            return erb(:index)
          else
            @current_user_id = nil
            return "Password is not correct! Try again."
          end
        else
          @current_user_id = nil
          return "Email is not correct! Try again."
        end
      else
        @current_user_id = nil
        return "Name is not correct! Try again."
      end
    end
  end

  # Log out button

  post "/log_out" do
    @current_user_id = nil
    @current_user_status = nil
    return erb(:sign_in)
  end


end