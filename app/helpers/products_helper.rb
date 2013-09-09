module ProductsHelper

  # Public: Get the Product categories.
  #
  # curr - The current section (default: 'all').
  #
  # Returns an ActiveSupport::SafeBuffer.
  def product_categories(curr='all')
    curr = 'all' if curr.blank?

    list_items = [
      content_tag(:li, link_to('All Bedding', products_path), class: curr == 'all' ? 'active' : ''),
      content_tag(:li, link_to('Boys Bedding', boys_products_path), class: curr == 'boys' ? 'active' : ''),
      content_tag(:li, link_to('Girls Bedding', girls_products_path), class: curr == 'girls' ? 'active' : '')
    ]

    content_tag :ul, class: 'categories side-nav' do
      list_items.map do |list_item|
        concat(list_item)
      end
    end
  end

  # Public: Get a link to the correct category.
  #
  # product - A Product with 0, 1, or many Tags (optional).
  #
  # Returns an ActiveSupport::SafeBuffer.
  def category_link(product=nil)

    if product.nil? || product.tags.size == 0 || product.tags.size > 1
      url = products_path
      text = 'View All Bedding'
    elsif product.tag_list.include? 'girls'
      url = girls_products_path
      text = 'View Girls Bedding'
    elsif product.tag_list.include? 'boys'
      url = boys_products_path
      text = 'View Boys Bedding'
    end

    link_to text, url, class: 'back-button'
  end

end
