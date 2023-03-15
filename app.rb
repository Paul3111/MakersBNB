require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/property_repository'

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
  get '/space' do
    @dates = [["2023-04-01","2023-04-07","2023-04-09"], ["2023-04-02","2023-04-09","2023-04-14"], ["2023-04-23","2023-04-24","2023-04-25"]]
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
end