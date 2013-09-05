require 'spec_helper'

describe ProductsHelper do

  describe '#product_categories' do

    it 'should return an unordered list' do
      expect(helper.product_categories).to have_selector('ul.side-nav')
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

end
