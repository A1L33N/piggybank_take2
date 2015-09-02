class Chore < ActiveRecord::Base
  belongs_to(:kid)
  belongs_to(:parent)

  validates(:description, {:presence => true})
  validates(:pay, {:presence => true })

end
