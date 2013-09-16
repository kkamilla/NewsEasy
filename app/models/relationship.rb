class Relationship < ActiveRecord::Base
  attr_accessible :newsfeed_id, :user_id
 # belongs_to :Newsfeed
  belongs_to :User
  validates :user_id, presence: true
end
