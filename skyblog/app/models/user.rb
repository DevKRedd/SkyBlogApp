class User < ApplicationRecord
    has_secure_password
    has_many :blog_posts, dependent: :destroy

    before_create :generate_auth_token

    validates :email, presence: true, uniqueness: true

    private

    def generate_auth_token
      self.auth_token = SecureRandom.hex(20)
    end
end
