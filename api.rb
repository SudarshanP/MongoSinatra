require 'sinatra/base'
require 'uri'
require 'mongo'
require 'json'

class MyAPI < Sinatra::Base
	get '/' do
	   uri = URI.parse(ENV['MONGOHQ_URL'])
	   conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
	   db = conn.db(uri.path.gsub(/^\//, ''))
	   coll = db['bookmarks']
	   
	   ret = "Failed"
	   ret = "Hello World from Sinatra & mongodb:" if db
	   coll.find().each { |row| ret += row.inspect } if coll
	   ret += "No bookmarks" unless coll
	   ret
	end
	post '/update/' do
       s = request.body.read
       puts s
       s
	end
	get '/env' do
	   ENV.inspect
	end
end
