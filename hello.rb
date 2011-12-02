require 'sinatra'
require 'uri'
require 'mongo'

get '/' do
   uri = URI.parse(ENV['MONGOHQ_URL'])
   conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
   db = conn.db(uri.path.gsub(/^\//, ''))
   coll = db['bookmarks']
   
   ret = "Failed"
   ret = "Hello World from Sinatra & mongodb:" if db
   ret = ret + coll.count
   ret
end
