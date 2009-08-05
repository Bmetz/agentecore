module HomeHelper

  def newest_pictures limit = 8
    Photo.find(:all, :order => 'created_at desc', :limit => limit)
  end


  def recent_comments limit = 5
    Comment.find(:all, :order => 'created_at desc', :limit => limit, :conditions => "commentable_type='Profile'")
  end

  def recent_members(page = 1, per_page = 5)
    Profile.paginate(:all, :order => 'created_at DESC', :conditions=>"user_id is not null", :page => page, :per_page => per_page)
  end

  def recent_forum_posts(page = 1, per_page = 5)
    ForumPost.paginate_by_sql("select forum_posts.* from forum_posts where forum_posts.id in (SELECT max(forum_posts.id) FROM forum_posts group by forum_posts.topic_id) order by forum_posts.id DESC", :page => page, :per_page => per_page)
  end

  def recent_blogs(page = 1, per_page = 5)
    Blog.paginate(:all, :order => 'created_at DESC', :page => page, :per_page => per_page)
  end

  def recent_wiki_revisions(page = 1, per_page = 5)
    WikiRevision.paginate_by_sql("select wiki_revisions.* from wiki_revisions where id in (SELECT max(id) FROM wiki_revisions group by page_id) order by wiki_revisions.id DESC", :page => page, :per_page => per_page)
  end

end

