module ForumTopicsHelper

  def topic_last_post_info(topic)
    unless (topic.posts.empty?)
      post = topic.posts.last
      "#{post.created_at} #{t(:ago_by)} "+link_to(post.owner.f, profile_path(post.owner))
    else
      t(:no_posts)
    end
  end

  def topic_details(topic)
    "#{topic.posts.count} "+(topic.posts.count == 1 ? t(:post_label) : t(:posts_label))
  end

end

