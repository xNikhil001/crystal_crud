require "kemal"
require "json"
require "./services"

include Service

before_all do |env|
  env.response.content_type = "application/json"
end

get "/" do
  {"test": "OK"}.to_json
end

get "/data" do |env|
  get_data
end

post "/data" do |env|
  name = env.params.json["name"].as(String)
  age = env.params.json["age"].as(Int64)

  add_data(name, age)
end

Kemal.run
