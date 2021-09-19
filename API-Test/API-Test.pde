import http.requests.*;

void setup(){
  size(400,400);
  PutRequest put = new PutRequest("http://127.0.0.1:5000/player/");
  put.addHeader("Content-Type", "application/json");
  put.addData("{\"color\":\"255\",\"x\":10,\"z\":10}");
  put.send();
  println(put.getContent());
}

void draw(){
  background(0);
  frameRate(10);
  GetRequest get = new GetRequest("http://127.0.0.1:5000/player/2");
  get.send();
  print(get.getContent());
  JSONObject response = parseJSONObject(get.getContent());
  
  ellipse(response.getInt("x"), response.getInt("y"), 10, 10);
  delay(2000);
}
