require 'spec_helper'

describe ProductsHelper do

  describe '#product_categories' do
    it 'should return an unordered list' do
      expect(helper.product_categories).to have_selector('ul.categories.side-nav')
    end

    it 'should default the current category to All' do
      expect(helper.product_categories).to(
       have_selector('li.active', text: "All Bedding (0)")
      )
    end

    it 'should have a link for each tag' do
      FactoryGirl.create(:product, tag_list: 'girls')
      expect(helper.product_categories).to(
        have_selector('li', text: 'Girls (1)')
      )
    end

    it 'should sort the tags alphabetically' do
      FactoryGirl.create(:product, tag_list: 'girls,boys')
      results = helper.product_categories
      expect(results.index('Girls')).to be > results.index('Boys')
    end

    context 'when passing a category in' do
      it 'should set that category to active' do
        FactoryGirl.create(:product, tag_list: 'phillies')
        expect(helper.product_categories('phillies')).to(
          have_selector('li.active', text: /Phillies/)
        )
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
      it 'should link to that category' do
        @product.update_attributes(tag_list: 'boys')
        url = '/shop/category/boys'
        expect(helper.category_link(@product)).to(
          have_selector("a[href='#{url}']", text: "View Boys Bedding")
        )
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
