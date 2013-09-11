# Public: All helpers that are to be used application-wide are in here. Even
# though all helpers are application-wide, it makes sense to put them here for
# clarity.
module ApplicationHelper

  # Public: Render markdown for a given String.
  #
  # text  - The String to render as markdown.
  #
  # Returns a String.
  def markdown(text)
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true
    ).render(text).html_safe
  end

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
      link_to('Contact', new_inquiry_path, remote: true),
      link_to('Blog', posts_path, class: curr == 'posts' ? 'active' : '')
    ]

    if opts[:include_admin] ||= false
      if admin_signed_in?
        links << link_to('Admin', admin_products_path)
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

  # Public: Get the Admin Navigation UL.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def admin_navigation
    elements = [
      link_to('Products', admin_products_path),
      link_to('Orders', admin_charges_path),
      link_to('Inquiries', admin_inquiries_path),
      link_to('Blog', admin_posts_path)
    ]

    content_tag :ul, class: 'global-navigation admin-navigation' do
      elements.map do |link|
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
