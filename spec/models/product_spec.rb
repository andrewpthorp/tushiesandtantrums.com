require 'spec_helper'

describe Product do
  include MoneyRails::TestHelpers

  describe '.mass-assignment' do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:price) }
    it { should allow_mass_assignment_of(:price_in_cents) }
    it { should allow_mass_assignment_of(:shipping) }
    it { should allow_mass_assignment_of(:shipping_in_cents) }
    it { should allow_mass_assignment_of(:tag_list) }
    it { should allow_mass_assignment_of(:images_attributes) }
    it { should allow_mass_assignment_of(:images) }
    it { should_not allow_mass_assignment_of(:slug) }
  end

  describe '.associations' do
    it { should have_many(:images).dependent(:destroy) }
    it { should accept_nested_attributes_for(:images).allow_destroy(true) }
  end

  describe '.validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price_in_cents) }
    it { should validate_presence_of(:shipping_in_cents) }

    describe '.images' do
      let (:image) { Image.new }
      let (:product) { Product.new(images: []) }

      it 'should have validation errors if images is empty' do
        product.valid?
        product.errors[:images].should_not be_empty
      end

      it 'should not have validation errors if images is not empty' do
        product.images << image
        product.valid?
        product.errors[:images].should be_empty
      end
    end
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
    describe '.newest' do
      it 'should order by created_at DESC, id DESC' do
        Product.newest.to_sql.should =~ /ORDER BY created_at DESC, id DESC/
      end
    end
  end

  describe '.friendly_id' do
    it 'should set a slug' do
      product = FactoryGirl.create(:product)
      product.slug.should_not be_nil
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

    describe '#primary_image' do
      it 'should return the correct image' do
        product = FactoryGirl.create(:product_with_multiple_images)
        expect(product.primary_image).to be_primary
      end
    end
  end
end
