require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
@@message = ""


get ("/") do
  @title = ""
  erb(:index)
end

#####Parents
get('/parents') do
  @title = "Parent Login"
  @parents = Parent.all
  erb(:parents)
end

#add new parent
post('/parents') do
  name = params.fetch('parent_name')
  bank_name = params.fetch('bank_name')
  parent = Parent.create({:name => name, :bank_name => bank_name})
  redirect back
end

#get one parent
get('/parents/:id') do
  id = params.fetch('id').to_i()
  @parent = Parent.find(id)
  @kids = @parent.kids()
  @title = @parent.bank_name
  @requests = @parent.requests
  erb(:parent)
end

#post new kid to parent
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

#parents - see kid's account
get('/parent/kids/:id') do
  id = params.fetch('id').to_i
  @kid = Kid.find(id)
  @transactions = @kid.transactions
  @title = @kid.account_name
  @current_date = Time.now.strftime("%Y-%m-%d")
  erb(:parent_kid)
end

######Kids

get('/kid') do
  newname = params.fetch('kid_name')
  whereclause = "lower(name) = '" + newname.downcase + "'"
  there = Kid.where(whereclause)

  if there == []
    @@message = "We can't find your account.  Ask your parents to login"
    redirect '/'
  else
    @@message = ""
    @kid = there.first
    @transactions = @kid.transactions
    @requests = @kid.requests
      erb(:kid_info)
  end
end

post('/kids/:id') do
  id = params.fetch('id').to_i
  kid = Kid.find(id)
  amount = params.fetch('amount').to_f
  if transaction_type.=="withdrawal"
      amount = amount.abs.*(-1)
  else
    amount
  end
  description = params.fetch('description')
  date = params.fetch('date')
  transaction = Transaction.create(:transaction_type => transaction_type, :kid_id => kid.id, :amount => amount, :date => date, :description => description)
  redirect back
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

patch('/parent/:id/pay_kid') do
  amount = params.fetch('amount').to_f
  kid_id = params.fetch('kid_id')
  chore_id = params.fetch('chore_id').to_i
  chore = Chore.find(chore_id)
  description = chore.description
  new_transaction = Transaction.create({:amount => amount, :transaction_type => 'deposit', :description => description, :date => Date.today, :kid_id => kid_id })
  chore.destroy
  redirect back
end

######Requests

##kid request form
post('/kid/:id/request') do
  kid_id = params.fetch('kid_id').to_i
  parent_id = params.fetch('parent_id').to_i
  request_type = params.fetch('request_type')
  amount = params.fetch('amount').to_f
  description = params.fetch('description')
  request = Request.create({:request_type => request_type, :amount => amount, :description => description, :kid_id => kid_id, :parent_id => parent_id})
  redirect back
end

post('/parent/:id/request') do
  kid_id = params.fetch('kid_id').to_i
  description = params.fetch('description')
  amount = params.fetch('amount').to_f
  transaction_type = params.fetch('transaction_type')
  if transaction_type.=="withdrawal"
      amount = amount.abs.*(-1)
  else
    amount
  end
  date = Date.today
  new_transaction = Transaction.create({:amount => amount, :transaction_type => transaction_type, :description => description, :date => date, :kid_id => kid_id })
  request_id = params.fetch('request_id').to_i
  request = Request.find(request_id)
  request.destroy
  redirect back
end
