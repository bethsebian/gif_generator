class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :gif
  has_one :category, through: :gif
end
