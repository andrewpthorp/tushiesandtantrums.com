class Admin < ActiveRecord::Base

  # Internal: Allow mass-assignment.
  attr_accessible :email, :password, :remember_me

  # Internal: Included devise modules.
  devise :database_authenticatable, :rememberable, :trackable, :validatable

end
