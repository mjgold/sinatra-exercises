require 'sinatra'
require_relative 'db'

get '/' do
  @recipes = Recipe.all
  erb :recipes
end

post '/recipes' do
  puts params
  # title = params[:title]
  # created_by = params[:created_by]
  # description = params[:description]
  # instructions = params[:instructions]

  Recipe.create(title: params[:title],
                created_by: params[:created_by],
                description: params[:description],
                instructions: params[:instructions])
  erb :recipes
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
