class User < ApplicationRecord
    has_many :blog_post, dependent: :destroy
    validates(:name, presence: true, length: {maximum:45})
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length: {maximum:45}, 
              format: { with: VALID_EMAIL_REGEX }, 
              uniqueness: true)
end
