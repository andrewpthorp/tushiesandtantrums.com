# Public: The Image class handles storing multiple images for Products. They
# CarrierWave ImageUploader was removed from the Product model and added to the
# Image model, with a has_many/belongs_to relationship between Products and
# Images.
class Image < ActiveRecord::Base

  # Internal: Each Image belongs to a Product.
  belongs_to :product

  # Internal: Validates the presence of :file.
  validates :file, presence: true

  # Internal: Use CarrierWave to mount the ImageUploader on :file.
  mount_uploader :file, ImageUploader

  # Internal: Only call :unset_other_primary_images if the Image is :primary.
  before_save :unset_other_primary_images, if: :primary?

  # Internal: Make sure we have atleast one :primary Image for a Product.
  before_save :ensure_one_primary

  # Public: Get all Images for a given Product.
  #
  # product_id - The :id of a Product to get all Images for.
  #
  # Returns an ActiveRecord::Relation.
  scope :for_product, -> (product_id) { where(product_id: product_id) }

  # Public: Get all Images with :primary set to true.
  #
  # Returns an ActiveRecord::Relation.
  scope :primary, -> { where(primary: true) }

protected

  # Internal: When :primary is set to true, we want to set :primary to false for
  # every other Image that is bound to the given Product.
  #
  # Returns nothing.
  def unset_other_primary_images
    Image.for_product(self.product_id).primary.update_all(primary: false)
  end

  # Internal: When :primary is set to false, but there are no Images for the
  # given Product, we should default :primary to true.
  #
  # Returns nothing.
  def ensure_one_primary
    self.primary = true if Image.for_product(self.product_id).primary.none?
  end

end
