require 'sinatra'

get '/' do
  erb :index
end

get '/goodbye' do
  @title = 'Goodbye!'

  erb :index
end

get '/users/:username' do
  @title = "My name is " + params[:username].to_s

  erb :index
end

get '/search' do
  erb :index
end

get '/pages/:pagename/*' do
  erb :index
end

get '/reference/*' do
  erb :index
end
