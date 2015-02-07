require 'sinatra'
require_relative 'db'
require 'sinatra/flash'

enable :sessions

get '/' do
  @recipes = Recipe.all
  @recipe = Recipe.new
  erb :recipes
end

post '/recipes' do
  @recipe = Recipe.create(
                title: params[:title],
                created_by: params[:created_by],
                description: params[:description],
                instructions: params[:instructions])
  @recipes = Recipe.all
  flash[:notice] = "Recipe created successfully!"
  redirect ("/recipes/#{@recipe.id}")
end

put '/recipes/:recipe_id' do
  @recipe = Recipe.get(params[:recipe_id])
  @recipe.update(
              title: params[:title],
              created_by: params[:created_by],
              description: params[:description],
              instructions: params[:instructions])
  flash[:notice] = "Recipe edited successfully!"
  redirect ("/recipes/#{@recipe.id}")
end

get '/recipes/:recipe_id' do
  if @recipe = Recipe.get(params[:recipe_id])
    erb :show_recipe
  else
    404
    # WHAT IS THIS MADNESS?!
    # https://en.wikipedia.org/wiki/404_Error
    # http://www.sinatrarb.com/intro.html#Return%20Values
  end
end

### WHY CAN'T REFERENCE THIS?
helpers do
  def post_or_put_route(object, prefix)
    object.new? ? prefix : prefix + "/#{object.id}"
  end
end
