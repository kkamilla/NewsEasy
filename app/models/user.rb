class User < ActiveRecord::Base
  has_many :newsfeeds
  has_many :relationships, foreign_key: "user_id", dependent: :destroy
  attr_accessible :name, :email, :password, :password_confirmation
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  attr_accessor :password, :password_salt, :password_hash
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  def self.authenticate(email, password)
   user = find_by_email(email)
  if user
    user
    else
     nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

def follow!(newsfeed)
  relationships.create!(newsfeed_id: newsfeed.id)
end
def unfollow!(newsfeed)
  relationships.find_by(newsfeed_id: newsfeed.id).destroy!
end
  def following?(newsfeed)
    relationships.find_by(newsfeeds_id: user.id)
  end
end