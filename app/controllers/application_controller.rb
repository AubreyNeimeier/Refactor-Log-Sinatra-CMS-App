require './config/environment'
require 'pry'
require 'rack-flash'

class ApplicationController < Sinatra::Base
use Rack::Flash
  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, 'apple_pancakes'
  end

  get "/" do
    erb :'/index'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
