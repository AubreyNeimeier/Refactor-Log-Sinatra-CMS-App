class ProjectsController < ApplicationController
  get "/projects/new" do
    erb :"projects/create_project"
  end

  post "/projects" do
    if logged_in?
      @project = Project.create(params[:project])
      @project.user_id = current_user.id
      @project.save
      redirect "/concerns"
    else
      redirect "/login"
    end
  end




end
