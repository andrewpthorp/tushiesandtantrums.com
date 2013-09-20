# Public: The Post model is what handles the blog of the website.
class Post < ActiveRecord::Base

  # Internal: Extend the FriendlyId module to allow us to use friendly_id.
  extend FriendlyId

  # Internal: Slug the :title of Products using FriendlyId.
  friendly_id :title, use: :slugged

  # Internal: Only show 5 per page, by default.
  paginates_per 5

  # Internal: Allow mass-assignment.
  attr_accessible :title, :body, :published

  # Internal: Validate presence of specific attributes.
  validates :title, :body, presence: true

  # Public: Get all Posts that have published set to true.
  #
  # Returns a Post::FriendlyIdActiveRecordRelation.
  scope :published, where(published: true)

  # Public: Get all Posts that are in draft form.
  #
  # Returns a Post::FriendlyIdActiveRecordRelation.
  scope :drafted, where(published: false)

  # Public: Get all Posts ordered by when they were created.
  #
  # Returns a Post::FriendlyIdActiveRecordRelation.
  scope :ordered, order('created_at DESC')

  # Public: Get all Posts except the Post with the given :id.
  #
  # id - The id of the Post to exclude from results.
  #
  # Returns a Post::FriendlyIdActiveRecordRelation.
  scope :exclude, lambda { |id| where('id != ?', id) }

  # Public: Get the most recent Post, ordered by created_at.
  #
  # Returns a Post.
  def self.latest
    published.ordered.first
  end

end
