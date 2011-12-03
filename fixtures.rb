def mrk(tit,url,tags)
    {"title"=>tit,"url"=>url,"tags"=>tags}
end

def initial_bookmarks(coll)
tmp = [
mrk("MSFT","www.microsoft.com",["os","office"]),
mrk("MSFT","www.microsoft.com",["os","office"]),
mrk("MSFT","www.microsoft.com",["os","office"]),
]
tmp each do |t|
   puts t.title
end
end

