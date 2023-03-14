require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/property_repository'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/space/new' do
    return erb(:property_form)
  end

  post '/space' do
    #if invalid_request_parameters_property?
    #  status 400
    #  return ''
    #end

    repo = PropertyRepository.new
    new_property = Property.new
    new_property.property_name = params[:property_name]
    new_property.property_description = params[:property_description]
    new_property.property_price = params[:property_price]
    new_property.property_avail_date = params[:property_avail_date]
    new_property.property_status = params[:property_status]
    new_property.owner_id = params[:owner_id]
    repo.create(new_property)
    return erb(:confirmation_page_property)
  end

  def invalid_request_parameters_property?
    return true if params[:property_name] == nil || params[:property_description] == nil || params[:property_status] == nil
    return true if params[:property_name] == "" || params[:property_description] ==  "" || params[:property_status] == ""  
    return false
  end
end