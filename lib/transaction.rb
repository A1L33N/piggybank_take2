class Transaction < ActiveRecord::Base
  belongs_to(:kid)

  validates(:kid_id, {:presence => true })
  validates(:amount, {:presence => true })
  validates(:type, {:presence => true})
  validates(:description, {:presence => true})
  validates(:date, {:presence => true})
end
