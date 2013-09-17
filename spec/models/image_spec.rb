require 'spec_helper'

describe Image do

  describe '.mass-assignment' do
    it { should allow_mass_assignment_of(:file) }
    it { should_not allow_mass_assignment_of(:product) }
  end

  describe '.associations' do
    it { should belong_to(:product) }
  end

  describe '.validations' do
    it { should validate_presence_of(:file) }
  end

end
