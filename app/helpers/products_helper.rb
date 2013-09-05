module ProductsHelper

  # Public: Get the Product categories.
  #
  # curr - The current section (default: 'all').
  #
  # Returns an ActiveSupport::SafeBuffer.
  def product_categories(curr='all')
    list_items = [
      content_tag(:li, link_to('All Bedding', products_path), class: curr == 'all' ? 'active' : ''),
      content_tag(:li, link_to('Boys Bedding', boys_products_path), class: curr == 'boys' ? 'active' : ''),
      content_tag(:li, link_to('Girls Bedding', girls_products_path), class: curr == 'girls' ? 'active' : '')
    ]

    content_tag :ul, class: 'side-nav' do
      list_items.map do |list_item|
        concat(list_item)
      end
    end
  end

end
