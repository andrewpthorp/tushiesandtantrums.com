# Public: All helpers that are to be used for Products are in here. Even though
# all helpers are application-wide, it makes sense to put them here for clarity.
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
      content_tag(:li, link_to('Girls Bedding', girls_products_path), class: curr == 'girls' ? 'active' : ''),
      content_tag(:li, link_to('Ready to Ship', ready_ship_products_path), class: curr == 'ready-ship' ? 'active' : '')
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

    link_to text, url, class: 'icon-reply back-button'
  end


  # Public: Get a div with image thumbnails for the Product show page.
  #
  # product - A Product with 0, 1, or many Images.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def image_toolbar(product)
    return if product.images.size <= 1

    content_tag :ul, class: 'toolbar' do
      product.images.map do |image|
        concat(content_tag(:li, image_tag(image.file.thumb),
                                class: 'image-thumb',
                                data: { src: image.file.url }))
      end
    end
  end

end
