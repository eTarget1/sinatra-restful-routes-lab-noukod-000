class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time] )
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

 get '/recipes/:id/edit' do  #load edit form
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #edit action
  @recipes = Recipe.find_by_id(params[:id])
  @recipes.name = params[:name]
  @recipes.ingredients = params[:ingredients]
  @recipes.cook_time = params[:cook_time]
  @recipes.save
  redirect to "/recipes/#{@recipes.id}"
end

delete '/recipes/:id/delete' do #delete action
@recipes = Recipe.find_by_id(params[:id])
@recipes.delete
redirect to '/recipes'
end

end
