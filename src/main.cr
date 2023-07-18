require "kemal"
require "pg"
require "json"

db = DB.open "postgres://nikhil@localhost/test"

get "/" do
  {"test": "OK"}.to_json
end

get "/data" do
  arr = [] of NamedTuple(name: String, age: Int32 | Int64)

  db.query "select name, age from contacts" do |rs|
    rs.each do
      arr << {name: rs.read(String), age: rs.read(Int32 | Int64)}
    end
  end

  arr.to_json
end

post "/data" do |env|
  name = env.params.json["name"].as(String)
  age = env.params.json["age"].as(Int64)

  rs = db.query "insert into contacts (name, age) values ('#{name}', '#{age}')"

  puts rs

  "Hello"
end

Kemal.run