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
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }

end