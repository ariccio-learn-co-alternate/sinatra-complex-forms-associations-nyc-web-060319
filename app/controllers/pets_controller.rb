class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    # binding.pry
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    # binding.pry
    if params[:pet][:owner][:name] != ""
      @new_owner = Owner.create(params[:pet][:owner])
      # binding.pry
      @pet = Pet.create!(name: params[:pet][:name], owner: @new_owner)
      # binding.pry
    else
      @pet = Pet.create!(name: params[:pet][:name], owner: params[:owner])
      # binding.pry
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    # binding.pry
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
      Pet.update!(@pet.id, name: params[:pet][:name], owner: @new_owner)
      # binding.pry
      # puts ""
    else
      # binding.pry
      Pet.update!(@pet.id, params[:pet])
      # binding.pry
      # puts ""
    end
    redirect to "pets/#{@pet.id}"
  end
end