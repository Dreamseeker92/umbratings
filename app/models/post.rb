class Post < ApplicationRecord
  has_many :ratings
  belongs_to :author

  delegate :login, to: :author, prefix: true
end
