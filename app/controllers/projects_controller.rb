class ProjectsController < ApplicationController
  get "/projects/new" do
    erb :"projects/create_project"
  end

  post "/projects" do
    if logged_in? && !params[:project][:name] == "" && !params[:project][:date_created] == "" && !params[:project][:summary] == ""
      flash[:message] = "A note and file name, and method name are required."
      @project = Project.create(params[:project])
      @project.user_id = current_user.id
      @project.save
      redirect "/concerns"
    else
      flash[:message] = "A name, date, and summary are required."
      redirect "/login"
    end
  end

  get "/projects/:id" do
    #view a single project
    #has validation but no message
    @project = Project.find_by_id(params[:id])
    if @project && logged_in? && @project.user_id == current_user.id
      @concerns = Concern.where(project_id: params[:id])
      erb :"/projects/show_project"
    else
      redirect "/login"
    end
  end


  get "/projects/:id/edit" do
    #edit a single project
    #has validation but no message
    @project = Project.find_by_id(params[:id])
    if @project && logged_in? && @project.user_id == current_user.id
      erb :"/projects/edit_project"
    else
      redirect "/login"
    end
  end

  post "/projects/:id" do
    #catches data to update a single project
    @project = Project.find_by_id(params[:id])
    @project.update(params[:project])
    @project.save
    redirect "/projects/#{@project.id}"
  end


  delete "/projects/:id/delete" do
    #delete a single project
    #has validations
    @project = Project.find_by_id(params[:id])
    if logged_in? && @project.user_id == current_user.id
      @project.delete
      redirect "/concerns"
    else
      redirect '/login'
    end
  end




end
