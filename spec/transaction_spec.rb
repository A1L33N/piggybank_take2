require('spec_helper')

describe(Transaction) do
  it { should validate_presence_of (:kid_id) }
  it { should validate_presence_of (:amount) }
  it { should validate_presence_of (:type) }
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:date) }


end
