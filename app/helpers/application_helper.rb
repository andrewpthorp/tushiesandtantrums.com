module ApplicationHelper

  def navigation(curr='home')
    links = [
      link_to('Home', root_path, class: curr == 'home' ? 'active' : ''),
      link_to('Shop', products_path, class: curr == 'products' ? 'active' : ''),
      link_to('Contact', '#', class: curr == 'contact' ? 'active' : ''),
      link_to('Blog', '#', class: curr == 'blog' ? 'active' : '')
    ]

    content_tag :ul, id: 'global-navigation' do
      links.map do |link|
        concat(content_tag(:li, link))
      end
    end
  end

end
