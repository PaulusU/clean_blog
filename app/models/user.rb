class User < ApplicationRecord
    has_many :blog_post, dependent: :destroy
    validates(:name, presence: true, length: {maximum:45})
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length: {maximum:45}, 
              format: { with: VALID_EMAIL_REGEX }, 
              uniqueness: true)
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def create_reset_digest
            self.reset_token = User.new_token
            update_attribute(:reset_digest, User.digest(reset_token))
            update_attribute(:reset_sent_at, Time.zone.now)
    end
end
