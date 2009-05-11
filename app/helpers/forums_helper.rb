module ForumsHelper
  
  def forum_details(forum)
    "#{forum.posts.count} "+(forum.posts.count == 1 ? t(:post_label) : t(:posts_label))+" #{t(:in)} #{forum.topics.count} "+(forum.topics.count == 1 ? t(:topic_helper_label) : t(:topics_helper_label))
  end
  
  def forum_last_post_info(forum)
    unless (forum.posts.empty?)
      post = forum.posts.last
      "#{time_ago_in_words post.created_at} #{t(:ago_br_by)} "+link_to(post.owner.f, profile_path(post.owner))+"<br/>#{t(:in)} "+link_to(post.topic.title, forum_topic_path(post.topic.forum, post.topic))
    else
      t(:no_posts)
    end
  end
end
