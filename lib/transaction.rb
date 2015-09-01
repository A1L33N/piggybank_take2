class Transaction < ActiveRecord::Base
  belongs_to(:kid)
end
