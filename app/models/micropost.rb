# == Schema Information
# Schema version: 20101127025851
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  # note: don't want to make 'user_id' attr_accessible
  # --> would allow one to change who made post
  attr_accessible :content

  belongs_to :user

  validates :content, :presence => true, :length => {:maximum => 140}
  validates :user_id, :presence => true

  default_scope :order => "microposts.created_at DESC"

  #scope: allows us to chain methods
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private

  def self.followed_by(user)
    # NOTE: the following line is replaced by the subsequent
    #   SQL subselect, which allows for the followed_ids to
    #   be assembled at the DB level --> quicker/less memory
    # followed_ids = user.following.map(&:id).join(", ") 
    followed_ids = %(SELECT followed_id FROM relationships
                     where follower_id = :user_id)
    where("user_id IN (#{followed_ids}) OR user_id = :user_id", 
          :user_id => user)
  end

end
