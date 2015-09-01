require('spec_helper')

describe(Transaction) do
  it { should validate_presence_of (:kid_id) }
  it { should validate_presence_of (:amount) }
  it { should validate_presence_of (:transaction_type) }
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:date) }


  describe('#sum') do
    it 'returns the sum of all transactions' do
      parent1 = Parent.create({:name => 'Jane', :bank_name => 'Mom Money'})
      kid1 = Kid.create({:name => "Joey", :account_name => 'The Money Pit', :beginning_balance => 50.00, :goal => 500.00, :parent_id => parent1.id})
      date = Date.new(2015, 12, 29)
      transaction1 = Transaction.create({:amount => 50.00, :transaction_type => 'deposit', :description => 'birthday gift', :date => date, :kid_id => kid1.id})
      transaction2 = Transaction.create({:amount => 5.00, :transaction_type => 'deposit', :description => 'allowance', :date => date, :kid_id => kid1.id})
      expect(kid1.transactions.sum(:amount).to_f).to eq(55.00)
    end
  end
end
