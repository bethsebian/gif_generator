class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :gif
  has_many :categories, through: :gifs
end
