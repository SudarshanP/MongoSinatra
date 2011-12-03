def mrk(tit,url,tags)
    {"title"=>tit,"url"=>url,"tags"=>tags}
end

def initial_bookmarks(coll)
tmp = [
mrk("MSFT","www.microsoft.com",["os","office"]),
mrk("AMZN","www.amazon.com",["cloud","books"]),
mrk("APPL","www.apple.com",["iPhone","iPad"]),
]
tmp.each do |t|
   puts t["title"]
end
end

