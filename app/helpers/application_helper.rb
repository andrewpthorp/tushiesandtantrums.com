module ApplicationHelper

  # Public: Get the Global Navigation UL.
  #
  # curr - The current section (default: 'home').
  #
  # Returns an ActiveSupport::SafeBuffer.
  def navigation(curr='home')
    links = [
      link_to('Home', root_path, class: curr == 'home' ? 'active' : ''),
      link_to('Shop', products_path, class: curr == 'products' ? 'active' : ''),
      link_to('Contact', '#', class: curr == 'contact' ? 'active' : ''),
      link_to('Blog', '#', class: curr == 'blog' ? 'active' : '')
    ]

    content_tag :ul, class: 'global-navigation' do
      links.map do |link|
        concat(content_tag(:li, link))
      end
    end
  end

  # Public: Get the Social Links UL.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def social_links
    links = [
      link_to('', 'https://www.facebook.com/pages/Tushies-and-Tantrums/161710933901582', class: 'facebook'),
      link_to('', '#', class: 'twitter'),
      link_to('', 'http://www.etsy.com/shop/simplysassynsweet', class: 'etsy'),
    ]

    content_tag :ul, class: 'social-links' do
      links.map do |link|
        concat(content_tag(:li, link))
      end
    end
  end

end
