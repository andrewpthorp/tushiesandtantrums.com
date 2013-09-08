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
      before do
        @product = FactoryGirl.create(:product, price_in_cents: 10000,
                                      shipping_in_cents: 2000)
      end

      it 'should add the price and shipping' do
        @product.total.fractional.should eq(12000)
      end

      context 'when including the tax' do
        it 'should add the tax into the total' do
          @product.total(include_tax: true).fractional.should eq(12095)
        end
      end
    end

    describe '#tax' do
      it 'should calculate correctly' do
        product = FactoryGirl.create(:product, price_in_cents: 10000)
        product.tax.fractional.should eq(95)
      end
    end
  end
end
