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
      content_tag(:li, link_to("All Bedding (#{Product.count})", products_path), class: curr == 'all' ? 'active' : '')
    ]

    Product.tag_counts.sort{ |a,b| a.name <=> b.name }.each do |t|
      item_class = t.name == curr ? 'active' : ''
      list_items << content_tag(:li, link_to("#{t.name.titleize} Bedding (#{t.count})", category_products_path(t.name)), class: item_class)
    end

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
    else
      tag = product.tag_list.first
      url = category_products_path(tag)
      text = "View #{tag.titleize} Bedding"
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
