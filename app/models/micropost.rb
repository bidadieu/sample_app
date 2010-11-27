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
  default_scope :order => "microposts.created_at DESC"
end
