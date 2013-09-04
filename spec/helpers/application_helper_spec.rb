require 'spec_helper'

describe ApplicationHelper do

  describe '#navigation' do

    it 'should return an unordered list' do
      expect(helper.navigation).to have_selector('ul#global-navigation')
    end

    it 'should have four links' do
      expect(helper.navigation).to have_selector('a', count: 4)
    end

    it 'should default the current section to Home' do
      expect(helper.navigation).to have_selector('a.active', text: 'Home')
    end

    [
      { section: 'home', text: 'Home', url: '/' },
      { section: 'products', text: 'Shop', url: '/products' },
      { section: 'contact', text: 'Contact', url: '#' },
      { section: 'blog', text: 'Blog', url: '#' }
    ].each do |p|
      context "when passing #{p[:section]}" do
        it "should set the current section to #{p[:text]}" do
          expect(helper.navigation(p[:section]))
            .to have_selector("a.active[href='#{p[:url]}']", text: p[:text])
        end
      end
    end

  end

end
