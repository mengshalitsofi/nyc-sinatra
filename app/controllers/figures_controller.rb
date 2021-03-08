class FiguresController < ApplicationController
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  post '/figures' do
    figure = Figure.create(name: params["figure"]["name"])
    if !params["title"]["name"].empty?
      figure.titles << Title.create(name: params["title"]["name"])
    else
      if params["figure"]["title_ids"] != nil
        figure.titles << Title.find(params["figure"]["title_ids"][0])
      end
    end

    if !params["landmark"]["name"].empty?
      figure.landmarks << Landmark.create(params["landmark"])
    else
      if params["figure"]["landmark_ids"] != nil 
        figure.landmarks << Landmark.find(params["figure"]["landmark_ids"][0])
      end
    end

    figure.save
    redirect to "figures/#{figure.id}"
  end
  
  get "/figures" do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/edit"
  end

  patch "/figures/:id" do
    figure = Figure.find(params[:id])

    figure.name = params["figure"]["name"]
    figure.titles = []
    if !params["title"]["name"].empty?
      figure.titles << Title.create(name: params["title"]["name"])
    else
      if params["figure"]["title_ids"] != nil
        figure.titles << Title.find(params["figure"]["title_ids"][0])
      end
    end

    figure.landmarks = []
    if !params["landmark"]["name"].empty?      
      figure.landmarks << Landmark.create(params["landmark"])
    else
      if params["figure"]["landmark_ids"] != nil 
        figure.landmarks << Landmark.find(params["figure"]["landmark_ids"][0])
      end
    end
    figure.save
    redirect "/figures/#{params[:id]}"
  end
end
