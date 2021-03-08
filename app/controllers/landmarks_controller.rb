class LandmarksController < ApplicationController
  get "/landmarks/new" do
    erb :"/landmarks/new"
  end

  post "/landmarks" do
    landmark = Landmark.create(params[:landmark])
    redirect "/landmarks/#{landmark.id}"
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/show"
  end

  patch "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    erb :"/landmarks/show"
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/edit"
  end

  get "/landmarks" do
    @landmarks = Landmark.all
    erb :"/landmarks/index"
  end
end
