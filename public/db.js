handler = function(data) {alert(data);}
window.db = {};
db._get = function(path,handler) {
    $.ajax({
      type: 'GET',
      url: path,
      contentType: "application/json",
      processData: false,
      success: handler,
      dataType: "text"
    });
}
db._post = function(path,data,handler) {
    $.ajax({
      type: 'POST',
      url: path,
      contentType: "application/json",
      processData: false,
      "data": data,
      success: handler,
      dataType: "text"
    });
}
db.get = function (path) {
}
db.list = function (path,pgnum,perpg) {
}
db.insert = function (tbl,data) {
   alert(tbl+":"+data);
   db._post("/"+tbl+"/insert",data,handler);
}
db.update = function (tbl,id,data) {
   db._post("/"+tbl+"/update/"+id,data,handler);
}
db.delete  = function (path,data) {
   db._post("/delete/"+path,handler);
}

function Update() {
   d = $('#updatebox').val();
   db.update("",d);
}
