# Public: The Post model is what handles the blog of the website.
class Post < ActiveRecord::Base

  # Internal: Extend the FriendlyId module to allow us to use friendly_id.
  extend FriendlyId

  # Internal: Slug the :title of Products using FriendlyId.
  friendly_id :title, use: :slugged

  # Internal: Allow mass-assignment.
  attr_accessible :title, :body

  # Internal: Validate presence of :title.
  validates :title, presence: true

  # Internal: Validates presence of :body.
  validates :body, presence: true

  # Public: Get all Posts that have published set to true.
  #
  # Returns a Post::FriendlyIdActiveRecordRelation.
  scope :published, where(published: true)

  # Public: Get all Posts that are in draft form.
  #
  # Returns a Post::FriendlyIdActiveRecordRelation.
  scope :drafted, where(published: false)

end
