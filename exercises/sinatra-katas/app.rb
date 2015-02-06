### Questions
# why rerun -x rackup not working?

require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite:tweets.db")

class Tweet
  include DataMapper::Resource
  property :id, Serial
  property :status, String
  property :user, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

# http://rubydoc.info/gems/sinatra#Routes


# CRUD Verb | HTTP Method
# ----------+------------
# Create    | POST
# Read      | GET
# Update    | PUT
# Destroy   | DELETE

#CREATE

# This will render an empty form so the user can enter
# the information to create a new tweet
get("/tweets/new") do
  @tweet = Tweet.new
  erb :new
end

# CRUD Verb: Create
# HTTP Method: POST

# This is the endpoint our "create form" submits to using
# the HTTP POST method.
post("/tweets") do
  puts params
  # @tweet = Tweet.create(
  #                      params['tweet']['status'],
  #                      params['tweet']['user']
  #                      )
  @tweet = Tweet.create(params[:tweet])

  if @tweet.saved?
    redirect '/'
  else
    erb :new
  end
end

# READ

get("/") do
  @tweets = Tweet.all
  erb :index
end

get("/tweets/:id") do
  @tweet = Tweet.get(params[:id]) # query the db for the id of the requested tweet
  erb :show
end

# UPDATE

# This renders the form used to edit a specific tweet
get("/tweets/edit/:id") do
  @tweet = Tweet.get(params[:id])
  erb :edit
end

# This is the endpoint our "edit form" submits to using
# the HTTP PUT method.
put("/tweets/:id") do
  @tweet = Tweet.get(params[:id])
  @tweet.attributes = params[:tweet]
  @tweet.save

  if @tweet.saved?
    redirect '/'
  else
    erb :edit
  end
end

# DESTROY

delete("/tweets/:id") do
  @tweet = Tweet.get(params[:id])
  @tweet.destroy
  redirect '/'
end
