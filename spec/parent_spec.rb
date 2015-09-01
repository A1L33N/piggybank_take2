require('spec_helper')

describe(Parent) do
  describe('#kids') do
    it { should have_many(:kids) }
  end

end
