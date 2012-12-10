require "sinatra"

require 'dm-core'
require 'dm-migrations'
require 'json'

require 'user.rb'

get '/' do
  'rspec-api-rest-example'
end

get '/api/users.json' do
  ret = []
  User.all.each do |u|
    ret << { :name=> u.name }
  end
  ret.to_json
end