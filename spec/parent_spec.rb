require('spec_helper')

describe(Parent) do
  describe('#kids') do
    it { should have_many(:kids) }
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:bank_name) }
  it { should validate_length_of(:name) }
  it { should validate_length_of(:bank_name) }

end
