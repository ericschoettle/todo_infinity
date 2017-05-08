require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("./lib/task")
require("./lib/list")
require("pg")
require('pry')

get("/") do
  @lists = List.all()
  @tasks = Task.all()
  erb(:index)
end

post("/lists") do
  name = params.fetch("name")
  @lists = List.all()
  @tasks = Task.all()
  erb(:index)
end

get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  task = Task.new({:description => description, :list_id => list_id})
  task.save()
  @list = List.find(list_id)
  erb(:list)
end

patch("/lists/:id") do
  name = params.fetch("name")
  @list = List.find(params.fetch("id").to_i())
  @list.update({:name => name})
  erb(:list)
end

get("/tasks/:id") do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  erb(:task)
end

delete("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  @list.delete()
  @lists = List.all()
  @tasks = Task.all()
  erb(:index)
end
