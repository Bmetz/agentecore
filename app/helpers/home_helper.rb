module HomeHelper

  def newest_pictures limit = 8
    Photo.find(:all, :order => 'created_at desc', :limit => limit)
  end


  def recent_comments limit = 5
    Comment.find(:all, :order => 'created_at desc', :limit => limit, :conditions => "commentable_type='Profile'")
  end

  def new_members(limit = 5)
    Profile.find(:all, :limit => limit, :order => 'created_at DESC', :conditions=>"user_id is not null")
  end

  def recent_forum_posts(limit = 5)
    ForumPost.find_by_sql "select forum_posts.* from forum_posts where forum_posts.id in (SELECT max(forum_posts.id) FROM forum_posts group by forum_posts.topic_id) order by forum_posts.id DESC limit #{limit}"
  end

  def recent_blogs(limit = 5)
    Blog.find(:all, :limit => limit, :order => 'created_at DESC')
  end

  def recent_wiki_revisions(limit = 5)
    WikiRevision.find(:all, :limit => limit, :order => 'created_at DESC', :include => :page)
  end

end

