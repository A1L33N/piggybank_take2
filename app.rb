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
  transaction = Transaction.create(:transaction_type => "deposit", :kid_id => kid.id, :amount => beginning_balance, :date => Date.today, :description => "first deposit")
  redirect back
end


######Kids
get('/kids/:id') do
  id = params.fetch('id').to_i
  @kid = Kid.find(id)
  @transactions = @kid.transactions
  erb(:kid)
end

post('/kids/:id') do
  id = params.fetch('id').to_i
  kid = Kid.find(id)
  transaction_type = params.fetch('transaction_type')
  amount = params.fetch('amount').to_f
  description = params.fetch('description')
  date = params.fetch('date')
  transaction = Transaction.create(:transaction_type => transaction_type, :kid_id => kid.id, :amount => amount, :date => date, :description => description)
  redirect back

end

get('/kid') do
  name = params.fetch('kid_name')
  @kid = Kid.find_by name: name
  @transactions = @kid.transactions
  erb(:kid_info)
end



##### Chores

get('/parent/:id/chores') do
  id = params.fetch('id').to_i
  @parent = Parent.find(id)
  @chores = @parent.chores
  erb(:chores)
end

post('/parent/:id/chores') do
  id = params.fetch('id').to_i
  @parent = Parent.find(id)
  description = params.fetch('description')
  pay = params.fetch('pay').to_f
  chore = Chore.create({:description => description, :pay => pay, :kid_id => nil, :parent_id => id, :available => true, :complete => false})
  redirect back

end

get('/kid_chores/:id') do
  id = params.fetch('id').to_i
  @kid = Kid.find(id)
  @parent = @kid.parent
  @chores = @parent.chores
  erb(:kid_chores)
end

patch('/parent/:id/assign_chores') do
  chore_id = params.fetch('chore_id').to_i
  chore = Chore.find(chore_id)
  kid_id = params.fetch('kid_id').to_i
  chore.update({:kid_id => kid_id, :available => false})
  redirect back
end

patch('/parent/:id/complete_chore') do
  chore_id = params.fetch('chore_id').to_i
  chore = Chore.find(chore_id)
  chore.update({:complete => true})
  redirect back
end
