class UsersController < ApplicationController
  get "/signup" do
    erb :"users/signup"
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/concerns"
    end
  end

  get "/login" do
    erb :"/users/login"
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect "/concerns"
     else
       redirect "/login"
     end
  end

#remove below route?
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @projects = Project.where(user_id: @user.id)
    @cocnerns = Concern.where(user_id: @user.id)
    #binding.pry
    erb :"/users/index"
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

end
