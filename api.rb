require "sinatra"

require 'dm-core'
require 'dm-migrations'
require 'json'

require 'user.rb'

get '/' do
  'rspec-api-rest-example'
end

# list users
get '/api/users.json' do
  ret = []
  User.all.each do |u|
    ret << { :name=> u.name }
  end
  ret.to_json
end

# add user, `name` param for name
post '/api/user_add.json' do
  user = User.new
  user.name = params[:name]
  user.save
end
