class Membership < ApplicationRecord
  belongs_to :gym 
  belongs_to :client

  validates :client, uniqueness: { scope: :gym, message: "should have only one membership with same gym" }
end
