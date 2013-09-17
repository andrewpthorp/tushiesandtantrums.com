# Public: The Image class handles storing multiple images for Products. They
# CarrierWave ImageUploader was removed from the Product model and added to the
# Image model, with a has_many/belongs_to relationship between Products and
# Images.
class Image < ActiveRecord::Base

  # Internal: Allow mass-assignment.
  attr_accessible :file

  # Internal: Each Image belongs to a Product.
  belongs_to :product

  # Internal: Validates the presence of :file.
  validates :file, presence: true

  # Internal: Use CarrierWave to mount the ImageUploader on :file.
  mount_uploader :file, ImageUploader

end
