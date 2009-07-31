module HomeHelper

  def newest_pictures limit = 4
    Photo.find(:all, :order => 'created_at desc', :limit => limit)
  end


  def recent_comments limit = 5
    Comment.find(:all, :order => 'created_at desc', :limit => limit, :conditions => "commentable_type='Profile'")
  end

  def new_members(limit = 5)
    Profile.find(:all, :limit => limit, :order => 'created_at DESC', :conditions=>"user_id is not null")
  end

  def recent_forum_posts(limit = 5)
    ForumTopic.find(:all, :limit => limit, :order => 'forum_posts.created_at DESC', :include => [:forum, :posts])
  end


end

