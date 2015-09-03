class Request < ActiveRecord::Base
  belongs_to(:kid)
  belongs_to(:parent)

  validates(:amount, {:presence => true})
  validates(:description, {:presence => true})
end
