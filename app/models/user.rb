class User < ActiveRecord::Base
  has_many :favorites
  has_many :gifs, through: :favorites
  has_many :categories, through: :gifs
  has_secure_password

  enum role: %w(default admin)
end
