require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/space' do
    return erb(:property_form)
  end

  post '/space' do
    return erb(:confirmation_page_property)
  end
end