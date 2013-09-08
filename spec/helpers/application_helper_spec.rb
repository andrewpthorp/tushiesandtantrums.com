require 'spec_helper'

describe ApplicationHelper do
  include Devise::TestHelpers

  describe '#markdown' do
    before do
      @renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      Redcarpet::Markdown.stub(:new).and_return(@renderer)
    end

    it 'should use the right options' do
      Redcarpet::Markdown.should_receive(:new)
        .with(Redcarpet::Render::HTML, autolink: true,
              space_after_headers: true)
        .and_return(@renderer)
      helper.markdown('foobar')
    end

    it 'should render markdown' do
      text = '<b>foobar</b>'
      @renderer.should_receive(:render).with(text).and_return(String.new)
      helper.markdown(text)
    end

    it 'should render html_safe' do
      new_string = String.new
      @renderer.stub(:render).and_return(new_string)
      new_string.should_receive(:html_safe)
      helper.markdown('foobar')
    end
  end

  describe '#navigation' do

    it 'should return an unordered list' do
      expect(helper.navigation).to have_selector('ul.global-navigation')
    end

    it 'should have four links' do
      expect(helper.navigation).to have_selector('a', count: 4)
    end

    it 'should default the current section to Home' do
      expect(helper.navigation).to have_selector('a.active', text: 'Home')
    end

    it 'should set the data-reveal-id on the Contact link' do
      expect(helper.navigation).to have_selector("a[data-reveal-id='contact']", text: 'Contact')
    end

    [
      { section: 'home', text: 'Home', url: '/' },
      { section: 'products', text: 'Shop', url: '/products' },
      { section: 'blog', text: 'Blog', url: '#' }
    ].each do |p|
      context "when passing #{p[:section]}" do
        it "should set the current section to #{p[:text]}" do
          expect(helper.navigation(p[:section]))
            .to have_selector("a.active[href='#{p[:url]}']", text: p[:text])
        end
      end
    end

    context 'when passing include_admin' do
      context 'and a user is signed in' do
        it 'should include a link to sign out' do
          sign_in_admin
          expect(helper.navigation('home', include_admin: true)).to have_selector('a', text: 'Sign out')
        end
      end

      context 'and a user is not signed in' do
        it 'should include a link to sign in' do
          expect(helper.navigation('home', include_admin: true)).to have_selector('a', text: 'Sign in')
        end
      end
    end

  end

  describe '#social_links' do
    before do
      @links = helper.social_links
    end

    it 'should return an unordered list' do
      expect(@links).to have_selector('ul.social-links')
    end

    it 'should have a link to facebook' do
      expect(@links).to have_selector('a.facebook')
    end

    it 'should have a link to twitter' do
      expect(@links).to have_selector('a.twitter')
    end

    it 'should have a link to etsy' do
      expect(@links).to have_selector('a.etsy')
    end

  end

end
