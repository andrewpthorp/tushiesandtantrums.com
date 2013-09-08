module ApplicationHelper

  # Public: Get the Global Navigation UL.
  #
  # curr  - The current section (default: 'home').
  # opts  - Hash of options to refine the links (default: {}, optional).
  #         :include_admin - Whether to include admin links (default: false).
  #
  # Returns an ActiveSupport::SafeBuffer.
  def navigation(curr='home', opts={})
    links = [
      link_to('Home', root_path, class: curr == 'home' ? 'active' : ''),
      link_to('Shop', products_path, class: curr == 'products' ? 'active' : ''),
      link_to('Contact', '#', data: { :'reveal-id' => 'contact' }),
      link_to('Blog', '#', class: curr == 'blog' ? 'active' : '')
    ]

    if opts[:include_admin] ||= false
      if admin_signed_in?
        links << link_to('Sign out', destroy_admin_session_path, method: :delete)
      else
        links << link_to('Sign in', new_admin_session_path)
      end
    end

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
