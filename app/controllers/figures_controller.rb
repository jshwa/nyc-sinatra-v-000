class FiguresController < ApplicationController

   get '/figures' do
     @figures = Figure.all
     erb :'/figures/index'
   end

   get '/figures/new' do
     @titles = Title.all
     @landmarks = Landmark.all
     erb :'/figures/new'
   end

   post '/figures' do
     @figure = Figure.create(params[:figure])
    #  titles = params[:figure][:title_ids]
    #  landmarks = params[:figure][:landmark_ids]
    #  titles.each {|title_id| @figure.titles << Title.find(title_id)} if titles
    #  landmarks.each {|land_id| @figure.landmarks << Landmark.find(land_id)} if landmarks
     @figure.titles.create(name: params[:title][:name]) if !params[:title][:name].empty?
     @figure.landmarks.create(name: params[:landmark][:name]) if !params[:landmark][:name].empty?
     @figure.save
     redirect "/figures/#{@figure.id}"
   end

   get '/figures/:id' do
     @figure = Figure.find(params[:id])
     erb :'/figures/show'
   end

   get '/figures/:id/edit' do
     @figure = Figure.find(params[:id])
     @titles = Title.all
     @landmarks = Landmark.all
     erb :'/figures/edit'
   end

   patch '/figures/:id' do
     @figure = Figure.find(params[:id])
     @figure.update(name: params[:figure][:name])

     titles = params[:figure][:title_ids]
     @figure.titles.clear
     titles.each {|title_id| @figure.titles << Title.find(title_id)} if titles
     @figure.titles.create(name: params[:title][:name]) if !params[:title][:name].empty?

     landmarks = params[:figure][:landmark_ids]
     @figure.landmarks.clear
     landmarks.each {|land_id| @figure.landmarks << Landmark.find(land_id)} if landmarks
     @figure.landmarks.create(name: params[:landmark][:name]) if !params[:landmark][:name].empty?

     @figure.save

     redirect "/figures/#{@figure.id}"
   end

end
