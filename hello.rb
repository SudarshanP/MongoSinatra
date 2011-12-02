require 'sinatra'

get '/' do
   db = Connection.new(ENV['DATABASE_URL']).db(db_name)
   if ENV['DATABASE_USER'] && ENV['DATABASE_PASSWORD']
      auth = db.authenticate(ENV['DATABASE_USER'], ENV['DATABASE_PASSWORD'])
   end
  "Hello World from Sinatra & mongodb:" + auth
end
