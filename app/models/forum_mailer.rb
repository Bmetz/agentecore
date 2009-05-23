class ForumMailer < ActionMailer::Base
  
  def new_post(user,post)
    @subject        = I18n.t(:new_post_on_topic_from_app, :topic => post.topic.title, :app => SITE_NAME)
    @recipients     = user.profile.email
    @body['user']   = user
    @body['post']   = post
    @from           = MAILER_FROM_ADDRESS
    @sent_on        = Time.new
    @content_type = "text/html"

  end

end
