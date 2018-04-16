class ConcernsController < ApplicationController

  get "/concerns" do
    if logged_in?
      @user = current_user
      @projects = Project.where(user_id: @user)
      @concerns = Concern.where(id: @user)
      erb :"concerns/index"
    else
      redirect "/login"
    end
  end

  get "/concerns/new" do
    @categories = ["Syntax", "Scope", "Semantics", "Functionality", "Not DRY", "Not Single Responsibility", "Needs testing"]
    @projects = Project.all
    erb :"concerns/create_concern"
  end

  post "/concerns" do
    #binding.pry
    if params[:note] == "" || params[:file_name] == ""
      redirect "/concerns/new"
    else
      @concern = Concern.create(file_name: params[:file_name], name_of_method: params[:name_of_method], note: params[:note], category: params[:category], project_id: params[:project_id])
      @concern.save
      redirect "concerns/#{@concern.id}"
    end
  end

  get "/concerns/:id" do
    if logged_in?
      @concern = Concern.find_by_id(params[:id])
      #uncomment this when we can create new projects so that radio buttons can be selected
      #@project = Project.find_or_create_by(project_id: params[:project_id])
      @slug = current_user.username.slug
      erb :"concerns/show_concern"
    else
      redirect "/login"
    end
  end

  get "/concerns/:id/edit" do
    if logged_in?
      @concern = Concern.find_by_id(params[:id])
      erb :"concerns/edit_concern"
    else
      redirect to "/login"
    end
  end



  post "/concerns/:id" do
    #catching edits to a concern
    @concern = Concern.find_by_id(params[:id])
    if params[:note] == "" || params[:file_name] == ""
      redirect to "/concerns/#{@concern.id}/edit"
    else
      @concern.update(file_name: params[:file_name], name_of_method: params[:name_of_method], note: params[:note], category: params[:category], project_id: params[:project_id])
      @concern.save
      redirect "/concerns/#{@concern.id}"
    end
  end



end
