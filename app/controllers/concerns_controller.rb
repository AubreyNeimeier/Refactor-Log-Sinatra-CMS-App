class ConcernsController < ApplicationController

  get "/concerns/new" do
    @categories = ["Syntax", "Scope", "Semantics", "Functionality", "Not DRY", "Not Single Responsibility", "Needs testing"]
    erb :"concerns/create_concern"
  end

  post "/concerns" do
    binding.pry
    if params[:note] == "" || params[:file_name] == ""
      redirect to "/concerns/new"
    else
      @concern = Concern.create(file_name: params[:file_name], name_of_method: params[:name_of_method], note: params[:note], category: params[:category])
      @concern.save
    end
  end

  get "concerns/:id/edit" do
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
      @concern.update(file_name: params[:file_name], name_of_method: params[:name_of_method], note: params[:note], category: params[:category])
      @concern.save
      redirect "/concerns/#{@concern.id}"
    end
  end



end
