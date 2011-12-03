require 'sinatra/base'
require 'uri'
require 'mongo'
require 'json'
require './fixtures'

def getDB()
    if ENV['MONGOHQ_URL'] 
       uri = URI.parse(ENV['MONGOHQ_URL'])
       conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL']) 
       return conn.db(uri.path.gsub(/^\//, ''))
    end
    conn = Mongo::Connection.new
    return conn['sample-db']
end

def getTable(tbl)
    db = getDB()
    #puts db[tbl].inspect
    return db[tbl]
end


class MyAPI < Sinatra::Base

    get '/' do    
       ret = "Welcome to the API"     
       ret 
    end
    get '/list/:table' do    
       ret = ""
       coll = getTable(params[:table])
       coll.find().each { |row| ret += row.inspect + "<HR>" }    
       ret 
    end
    post '/update/' do
       s = request.body.read
       puts s
       s
    end
    get '/env' do
       ret = ENV.inspect
       ret += "<hr>"
       getDB().collection_names.each { |name| ret+= name +"<br>"}
       ret
    end
    get '/fixtures' do
       initial_bookmarks(nil)
       "hi"
    end
end
