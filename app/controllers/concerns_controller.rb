require 'rack-flash'
class ConcernsController < ApplicationController

  get "/concerns" do
    if logged_in?
      @user = current_user
      @projects = current_user.projects
      #the below needs work. each project has concerns method.
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
    if params[:note] == "" || params[:file_name] == "" || params[:name_of_method] == ""
      flash[:message] = "A note and file name, and method name are required."
      redirect "/concerns/new"
    else
      @concern = Concern.create(file_name: params[:file_name], name_of_method: params[:name_of_method], note: params[:note], category: params[:category], project_id: params[:project_id])
      @concern.user_id = current_user.id
      @concern.save
      redirect "concerns/#{@concern.id}"
    end
  end

  get "/concerns/:id" do

    if logged_in?
      @concern = Concern.find_by_id(params[:id])
      #uncomment this when we can create new projects so that radio buttons can be selected
      #@project = Project.find_or_create_by(project_id: params[:project_id])
      erb :"concerns/show_concern"
    else
      redirect "/login"
    end
  end

  get "/concerns/:id/edit" do
    @concern = Concern.find_by_id(params[:id])
    if @concern && logged_in? && @concern.user_id == current_user.id
      @project_name = Project.find_by_id(@concern.project_id).name
      @categories = ["Syntax", "Scope", "Semantics", "Functionality", "Not DRY", "Not Single Responsibility", "Needs testing"]
      erb :"concerns/edit_concern"
    else
      redirect to "/login"
    end
  end

  post "/concerns/:id" do
    #catching edits to a concern
    @concern = Concern.find_by_id(params[:id])
    if params[:note] == "" || params[:file_name] == ""
      flash[:message] = "A note and file name are required."
      redirect to "/concerns/#{@concern.id}/edit"
    else
      @concern.update(note: params[:note], category: params[:category])
      @concern.save
      redirect "/concerns/#{@concern.id}"
    end
  end

  delete "/concerns/:id/delete" do
    @concern = Concern.find_by_id(params[:id])
    if logged_in? && @concern.user_id == current_user.id
      @concern.delete
      redirect "/concerns"
    else
      redirect '/login'
    end
  end



end
