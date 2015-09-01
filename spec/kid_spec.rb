require('spec_helper')

describe(Kid) do
  describe('#parent') do
    it { should belong_to(:parent) }
  end

  describe('#transactions') do
    it { should have_many(:transactions) }
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:account_name) }
  it { should validate_presence_of(:beginning_balance) }
  it { should validate_presence_of(:goal) }

end
