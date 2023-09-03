class Client < ApplicationRecord
  validates :membership, uniqueness: true
  has_many :memberships
  has_many :gyms, through: :memberships 
end
