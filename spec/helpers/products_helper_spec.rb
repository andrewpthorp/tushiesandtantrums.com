require 'spec_helper'

describe ProductsHelper do

  describe '#product_categories' do

    it 'should return an unordered list' do
      expect(helper.product_categories).to have_selector('ul.categories.side-nav')
    end

    it 'should have 3 links' do
      expect(helper.product_categories).to have_selector('a', count: 3)
    end

    it 'should default the current category to All' do
      expect(helper.product_categories).to have_selector('li.active', text: /All/)
    end

    [
      { category: 'all', text: 'All Bedding' },
      { category: 'boys', text: 'Boys Bedding' },
      { category: 'girls', text: 'Girls Bedding' }
    ].each do |p|
      context "with a category of #{p[:category]}" do
        it "should set the current category to #{p[:text]}" do
          expect(helper.product_categories(p[:category]))
            .to have_selector("li.active", text: p[:text])
        end
      end
    end

  end

  describe '#category_link' do
    before do
      @product = FactoryGirl.create(:product)
    end

    it 'should return a single link' do
      expect(helper.category_link).to have_selector('a', count: 1)
    end

    it 'should link back to products_path' do
      expect(helper.category_link)
        .to have_selector("a[href='/products']", text: 'View All Bedding')
    end

    context 'when the product has multiple categories' do
      it 'should link back to products_path' do
        @product.update_attributes(tag_list: 'boys,girls')
        expect(helper.category_link(@product))
          .to have_selector("a[href='/products']", text: 'View All Bedding')
      end
    end

    context 'when the product has no categories' do
      it 'should link back to products_path' do
        @product.update_attributes(tag_list: '')
        expect(helper.category_link(@product))
          .to have_selector("a[href='/products']", text: 'View All Bedding')
      end
    end

    context 'when the product has one category' do
      context 'and the category is boys' do
        it 'should link back to boys_products_path' do
          @product.update_attributes(tag_list: 'boys')
          text = 'View Boys Bedding'
          url = '/products/boys'
          expect(helper.category_link(@product)).to(
            have_selector("a[href='#{url}']", text: "#{text}")
          )
        end
      end

      context 'and the category is girls' do
        it 'should link back to girls_products_path' do
          @product.update_attributes(tag_list: 'girls')
          text = 'View Girls Bedding'
          url = '/products/girls'
          expect(helper.category_link(@product)).to(
            have_selector("a[href='#{url}']", text: "#{text}")
          )
        end
      end
    end

  end

end
