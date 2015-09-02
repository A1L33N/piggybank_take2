require('spec_helper')

describe(Chore) do
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:pay) }

  describe('#parent') do
    it { should belong_to(:parent) }
  end

  describe('#kid') do
    it { should belong_to(:kid) }
    end

end
