class Chore < ActiveRecord::Base
  belongs_to(:kid)
  belongs_to(:parent)
end
