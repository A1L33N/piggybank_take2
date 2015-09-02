require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



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
    redirect '/kid/' + @kid.id.to_s()
  end
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
