require 'sinatra'

DEBUG = true

puts settings.environment

def creator
  'mark!'
end

def time_of_day_message
  now = Time.now
  if now.hour > 15
    "it's getting late..."
  else
    'happy day'
  end
end

get '/' do
  @name = 'Bob'
  @title = 'Welcome to Inspector'

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
