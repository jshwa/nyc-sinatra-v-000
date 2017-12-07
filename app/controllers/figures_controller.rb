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
     @figure.update(params[:figure])
     @figure.titles.create(name: params[:title][:name]) if !params[:title][:name].empty?
     @figure.landmarks.create(name: params[:landmark][:name]) if !params[:landmark][:name].empty?
     @figure.save
     redirect "/figures/#{@figure.id}"
   end

end
