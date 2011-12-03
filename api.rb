require 'sinatra/base'
require 'uri'
require 'mongo'
require 'json'
require './fixtures'

class MyAPI < Sinatra::Base
    get '/' do
       if ENV['MONGOHQ_URL'] 
           uri = URI.parse(ENV['MONGOHQ_URL'])
           conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL']) 
           db = conn.db(uri.path.gsub(/^\//, ''))
       else 
           conn = Mongo::Connection.new
           db   = conn['sample-db']
       end
       
       coll = db['bookmarks']
       
       ret = "Failed"
       ret = "Hello World from Sinatra & mongodb:" if db
       coll.find().each { |row| ret += row.inspect } if coll
       ret += "No bookmarks" unless coll
       ret += "<hr>"
       db.collection_names.each { |name| ret+= name +"<br>"}
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
