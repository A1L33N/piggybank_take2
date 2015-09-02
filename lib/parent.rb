class Parent < ActiveRecord::Base
  has_many(:kids)
  has_many(:chores)

  validates(:name, {:presence => true, :length => { :maximum => 50 }})
  validates(:bank_name, {:presence => true, :length => { :maximum => 50 }})
end
