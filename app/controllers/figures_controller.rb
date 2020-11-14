class FiguresController < ApplicationController
  
  get '/figures' do
    @figures = Figure.all
    erb :'figure/index'  
  end

  get '/figures/new' do
    @landmarks = Landmark.all 
    @titles = Title.all 
    erb :'figure/new'
  end

  post '/figures' do
    @title = params[:title]
    @landmark = params[:landmark]
    @title_ids = params[:figure][:title_ids]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure = Figure.create(:name => params[:figure][:name])
    if !@title[:name].empty?
      t = Title.create(:name => @title[:name])
      @figure.titles << t
    end
    if @title_ids
      @title_ids.each do |id|
        t = Title.find(id)
        @figure.titles << t
      end
    end
    if !@landmark[:name].empty?
      l = Landmark.create(:name => @landmark[:name])
      @figure.landmarks << l
    end
    if @landmark_ids
      @landmark_ids.each do |id|
        l = Landmark.find(id)
        @figure.landmarks << l
      end
    end
    @figure.save
    redirect to "/figure/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @titles = Title.all 
    @landmarks = Landmark.all 
    @figure = Figure.find_by_id(params[:id])
    erb :'figure/edit'
  end

  patch '/figures/:id' do
    @title = params[:title]
    @landmark = params[:landmark]
    @title_ids = params[:figure][:title_ids]
    @landmark_ids = params[:figure][:landmark_ids]
    @figure = Figure.find_by_id(params[:id])
    @figure = @figure.update(:name => params[:figure][:name])
    if !@title[:name].empty?
      t = Title.create(:name => @title[:name])
      @figure.titles << t
    end
    if @title_ids
      @title_ids.each do |id|
        t = Title.find(id)
        @figure.titles << t
      end
    end
    if !@landmark[:name].empty?
      l = Landmark.create(:name => @landmark[:name])
      @figure.landmarks << l
    end
    if @landmark_ids
      @landmark_ids.each do |id|
        l = Landmark.find(id)
        @figure.landmarks << l
      end
    end
    @figure.save
    redirect to "/figure/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :"figure/show"
  end

end
