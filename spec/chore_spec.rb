require('spec_helper')

describe(Chore) do
  describe('#parent') do
    it { should belong_to(:parent) }
  end

  describe('#kid') do
    it { should belong_to(:kid) }
    end

end
