# == Schema Information
# Schema version: 2008100601002
#
# Table name: blogs
#
#  id         :integer(4)    not null, primary key
#  title      :string(255)
#  body       :text
#  profile_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Blog < ActiveRecord::Base
  has_many :comments, :as => :commentable, :order => "created_at asc"
  belongs_to :profile
  validates_presence_of :title, :body
  validate :can_send_news
  attr_immutable :id, :profile_id

  def can_send_news
    #"Deve ser um amigo para deixar comentários..."
    errors.add_to_base(I18n.t(:can_send_news, :default => '')) if news? and not profile.user.can_send_news
  end

  def after_create
    feed_item = FeedItem.create(:item => self)
    ([profile] + profile.friends + profile.followers).each{ |p| p.feed_items << feed_item }
  end


  def to_param
    "#{self.id}-#{title.to_safe_uri}"
  end

end

