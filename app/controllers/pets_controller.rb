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
      @owner = Owner.find(params[:pet][:owner_id])
      @pet = Pet.create!(name: params[:pet][:name], owner: @owner)
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
      @pet.update!(name: params[:pet][:name], owner_id: @new_owner.id)
      # binding.pry
      # puts ""
    else
      # binding.pry
      @pet.update!(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
      # binding.pry
      # puts ""
    end
    redirect to "pets/#{@pet.id}"
  end
end