require 'spec_helper'

describe Product do
  include MoneyRails::TestHelpers

  describe '.validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price_in_cents) }
    it { should validate_presence_of(:shipping_in_cents) }
    it { should validate_presence_of(:image) }
  end

  describe '.monetize' do
    it 'should monetize the column :price_in_cents' do
      monetize(:price_in_cents).as(:price).should be_true
    end

    it 'should monetize the column :shipping_in_cents' do
      monetize(:shipping_in_cents).as(:shipping).should be_true
    end
  end

  describe '.scopes' do
    describe '.random' do
      it 'should order random from the database' do
        Product.random.to_sql.should =~ /ORDER BY RANDOM/
      end
    end
  end

  describe '#methods' do
    describe '#total' do
      it 'should add the price and shipping' do
        product = FactoryGirl.create(:product)
        product.total.should eq(product.price + product.shipping)
      end
    end
  end
end
