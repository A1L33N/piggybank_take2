class Kid < ActiveRecord::Base
  belongs_to(:parent)
  has_many(:transactions)

  validates(:name, {:presence => true, :length => { :maximum => 50}})
  validates(:account_name, {:presence => true, :length => { :maximum => 50}})
  validates(:beginning_balance, {:presence => true})
  validates(:goal, {:presence => true})
end
