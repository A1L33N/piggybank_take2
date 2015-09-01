require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get ("/") do
  erb(:index)
end


#####Parents
get('/parents') do
  @parents = Parent.all
  erb(:parents)
end

post('/parents') do
  name = params.fetch('parent_name')
  bank_name = params.fetch('bank_name')
  parent = Parent.create({:name => name, :bank_name => bank_name})
  redirect back
end

get('/parents/:id') do
  id = params.fetch('id').to_i
  @parent = Parent.find(id)
  @kids = @parent.kids()
  erb(:parent)
end


post('/parents/:id') do
  id = params.fetch('id').to_i
  @parent = Parent.find(id)
  name = params.fetch('name')
  account_name = params.fetch('account_name')
  beginning_balance = params.fetch('beginning_balance').to_f
  goal = params.fetch('goal').to_f
  kid = Kid.create({:name => name, :account_name => account_name, :beginning_balance => beginning_balance, :goal => goal, :parent_id => id})
  redirect back
end


######Kids
get('/kids/:id') do
  erb(:kid)
end
