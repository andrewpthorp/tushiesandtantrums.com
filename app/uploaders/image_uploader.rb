# encoding: utf-8

# Public: A CarrierWave::Uploader::Base that allows me to upload files and
# attach them to models.
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Internal: A thumbnail version of the attachment.
  #
  # Examples
  #
  #   Product.first.image.thumb.url
  #   # => '/uploads/products/image/1/thumb_image.jpg'
  #
  # Returns an ImageUploader::Uploader.
  version :thumb do
    process :resize_to_fill => [50, 50]
  end

  # Internal: A version of the attachment to use as featured.
  #
  # Examples
  #
  #   Product.first.image.featured.url
  #   # => '/uploads/products/image/1/featured_image.jpg'
  #
  # Returns an ImageUploader::Uploader.
  version :featured do
    process :resize_to_fill => [970, 385]
  end

  # Internal: A version of the attachment to use on widgets.
  #
  # Examples
  #
  #   Product.first.image.widget.url
  #   # => '/uploads/products/image/1/widget_image.jpg'
  #
  # Returns an ImageUploader::Uploader.
  version :widget do
    process :resize_to_fill => [220, 180]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
