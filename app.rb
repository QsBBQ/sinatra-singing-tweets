require 'sinatra'
require 'data_mapper'
DataMapper.setup(:default, "sqlite:tweets.db")

class Tweet
  include DataMapper::Resource
  property :id,          Serial
  property :content, String
  property :owner, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

get "/" do
  @tweets = Tweet.all
  erb :tweets
end

get "/tweets/new" do
  @tweet = Tweet.new
  erb :knew
end

get "/tweets/:id" do
  @tweet = Tweet.get(params[id])
  erb :tweet
end

post "/tweets" do
  new_tweet = params[:tweet]
  @tweet = Tweet.create(new_tweet_info)
  if @tweet.saved?
    redirect "/"
  else
    erb :new
  end
end

get "/tweets/edit/id" do
  @tweet = Tweet.get(params[:id])
  if @tweet
    erb :edit
  else
    redirect "/404.html"
  end
end

puts "/tweets/:id" do
  @tweet = Tweet.get(params[:id])
  if tweet
    @tweet.update(params[:tweet])
  end
  redirect "/"
end

destroy "/tweets/:id" do
  @tweet = Tweet.get([:id])
  if @tweet
    @tweet.destroy
  end
  redirect "/"
end
