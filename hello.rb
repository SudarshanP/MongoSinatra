require 'sinatra'
require 'mongo'

get '/' do
   db = Connection.new(ENV['DATABASE_URL']).db(db_name)
   ret = "Failed"
   if ENV['DATABASE_USER'] && ENV['DATABASE_PASSWORD']
      auth = db.authenticate(ENV['DATABASE_USER'], ENV['DATABASE_PASSWORD'])
      ret = "Hello World from Sinatra & mongodb:"
   end
   ret
end
