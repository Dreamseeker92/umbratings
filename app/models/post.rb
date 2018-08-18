class Post < ApplicationRecord
  has_many :ratings
  belongs_to :author

end
