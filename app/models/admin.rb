# Public: This handles the administration of the website. This website will be
# a single-user system. For more information, visit the devise wiki on GitHub.
class Admin < ActiveRecord::Base

  # Internal: Included devise modules.
  devise :database_authenticatable, :rememberable, :trackable, :validatable

end
