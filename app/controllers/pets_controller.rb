class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create!(name: params["pet"]["name"])
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    if params[:pet][:owner][:name] != ""
      # binding.pry
      @new_owner = Owner.create(params[:pet][:owner])
      # binding.pry
      @pet.update!(name: params[:pet][:name], owner: @new_owner)
      # binding.pry
      # puts ""
    else
      # binding.pry
      @pet.update!(params[:pet])
      # binding.pry
      # puts ""
    end
    redirect to "pets/#{@pet.id}"
  end
end