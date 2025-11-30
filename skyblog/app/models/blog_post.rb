class BlogPost < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :content, presence: true
end
