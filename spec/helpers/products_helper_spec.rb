require 'spec_helper'

describe ProductsHelper do

  describe '#product_categories' do
    it 'should return an unordered list' do
      expect(helper.product_categories).to have_selector('ul.categories.side-nav')
    end

    it 'should have 4 links' do
      expect(helper.product_categories).to have_selector('a', count: 4)
    end

    it 'should default the current category to All' do
      expect(helper.product_categories).to have_selector('li.active', text: /All/)
    end

    [
      { category: 'all', text: 'All Bedding' },
      { category: 'boys', text: 'Boys Bedding' },
      { category: 'girls', text: 'Girls Bedding' },
      { category: 'ready-ship', text: 'Ready to Ship' }
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
        .to have_selector("a[href='/shop']", text: 'View All Bedding')
    end

    context 'when the product has multiple categories' do
      it 'should link back to products_path' do
        @product.update_attributes(tag_list: 'boys,girls')
        expect(helper.category_link(@product))
          .to have_selector("a[href='/shop']", text: 'View All Bedding')
      end
    end

    context 'when the product has no categories' do
      it 'should link back to products_path' do
        @product.update_attributes(tag_list: '')
        expect(helper.category_link(@product))
          .to have_selector("a[href='/shop']", text: 'View All Bedding')
      end
    end

    context 'when the product has one category' do
      context 'and the category is boys' do
        it 'should link back to boys_products_path' do
          @product.update_attributes(tag_list: 'boys')
          text = 'View Boys Bedding'
          url = '/shop/boys'
          expect(helper.category_link(@product)).to(
            have_selector("a[href='#{url}']", text: "#{text}")
          )
        end
      end

      context 'and the category is girls' do
        it 'should link back to girls_products_path' do
          @product.update_attributes(tag_list: 'girls')
          text = 'View Girls Bedding'
          url = '/shop/girls'
          expect(helper.category_link(@product)).to(
            have_selector("a[href='#{url}']", text: "#{text}")
          )
        end
      end
    end
  end

  describe '#image_toolbar' do
    context 'with one image' do
      let (:product) { FactoryGirl.create(:product) }
      let (:results) { helper.image_toolbar(product) }

      it 'should return nil' do
        expect(results).to be_nil
      end
    end

    context 'with multiple images' do
      let (:product) { FactoryGirl.create(:product_with_multiple_images) }
      let (:results) { helper.image_toolbar(product) }

      it 'should return an unordered list' do
        expect(results).to have_selector('ul.toolbar')
      end

      it 'should have a list item for each image' do
        expect(results).to have_selector('li.image-thumb',
                                         count: product.images.size)
      end
    end
  end

end
