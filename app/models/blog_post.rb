class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: {maximum:50}
  validates :summary, presence: true, length: {maximum:150}
  validates :content, presence: true
  validates :user_id, presence: true
end