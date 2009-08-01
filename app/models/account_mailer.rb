class AccountMailer < ActionMailer::Base
  
  def signup(user)
    @subject        = I18n.t(:signup_subject, :app => SITE_NAME)
    @recipients     = user.profile.email
    @body['user']   = user
    @from           = MAILER_FROM_ADDRESS
    @sent_on        = Time.new
    @headers        = {}
  end
  

  def forgot_password(email, name, login, password)
    @subject        = I18n.t(:forgot_password_subject, :app => SITE_NAME)
    @body['user']   = [email, name, login, password]
    @recipients     = email
    @from           = MAILER_FROM_ADDRESS
    @sent_on        = Time.new
    @headers        = {}
  end
  
  
  def follow inviter, invited, description
    @subject        = I18n.t(:follow_subject, :app => SITE_NAME)
    @recipients     = invited.email
    @body['inviter']   = inviter
    @body['invited']   = invited
    @body['description'] = description
    @from           = MAILER_FROM_ADDRESS
    @sent_on        = Time.new
    @headers        = {}
  end
end
