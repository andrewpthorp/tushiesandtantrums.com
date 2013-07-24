require 'spec_helper'

describe Product do
  include MoneyRails::TestHelpers

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price_in_cents) }
  it { should validate_presence_of(:image) }

  describe '.monetize' do
    it 'should monetize the column :price_in_cents' do
      monetize(:price_in_cents).as(:price).should be_true
    end
  end
end
