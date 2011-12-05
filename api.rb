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

def JSONResponse(results)
   rows = []
   results.each do |row| 
      r = JSON.parse(JSON.generate(row))
      r["_id"]=r["_id"]["$oid"]
      rows << r 
   end    
   JSON.generate({"rows"=>rows})
end

class MyAPI < Sinatra::Base

    get '/' do    
       ret = "Welcome to the API"     
       ret 
    end
    get '/:table/list/:skip/:limit' do    
       ret = ""
       coll = getTable(params[:table])
       l = params[:limit].to_i || 30
       s = params[:skip].to_i || 0
       ret = coll.find().limit(l).skip(s) #.each { |row| ret += row.inspect + "<HR>" }    
       JSON.generate(ret) 
    end
    get '/:table/list' do    
       ret = ""
       coll = getTable(params[:table])
       JSONResponse(coll.find()) 
    end
    get '/:table/:id' do    
       ret = ""
       id = BSON::ObjectId(params[:id])
       coll = getTable(params[:table])
       ob = coll.find_one({'_id'=>id})  
       ob["_id"] = params[:id]
       JSON.generate(ob)
    end
    post '/:table/insert' do
       begin
          s = request.body.read
          doc = JSON.parse(s)
          coll = getTable(params[:table])
          ret = coll.insert(doc)
          return "Inserted as :"+ret.inspect
       rescue
          puts "Bad JSON:"+s
          return "bad JSON"
       end
    end
    post '/:table/update/:id' do
       begin
          puts "aaaa"
          id = BSON::ObjectId(params[:id])
          s = request.body.read
          doc = JSON.parse(s)
          puts "bbbb"
          coll = getTable(params[:table])
          puts "cccc"
          ret = coll.update({'_id'=>id},doc)
          puts "dddd"
          #puts id+">>>"+doc
          return "Updated :"+id.inspect
       rescue
          puts "Bad JSON:"+s
          return "bad JSON"
       end
    end
    get '/:table/delete/:id' do    
       ret = ""
       coll = getTable(params[:table])
       id = BSON::ObjectId(params[:id])
       coll.remove({'_id'=>id})    
       ""
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
