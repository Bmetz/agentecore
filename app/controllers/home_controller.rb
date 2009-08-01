class HomeController < ApplicationController
  #skip_before_filter :login_required

  def contact
    return unless request.post?
    body = []
    params.each_pair { |k,v| body << "#{k}: #{v}"  }
    HomeMailer.deliver_mail(:subject=> t(:from_contact_page, :app => SITE_NAME), :body=>body.join("\n"))
    flash[:notice] = t(:thank_you_for_message)
    redirect_to contact_url
  end


  def index
    check_featured
    respond_to do |wants|
      wants.html {render}
      wants.rss {render :partial =>  'profiles/newest_member', :collection => new_members}
    end
  end

  def newest_members
    respond_to do |wants|
      wants.html {render :action=>'index'}
      wants.rss {render :layout=>false}
    end
  end
  def latest_comments
    respond_to do |wants|
      wants.html {render :action=>'index'}
      wants.rss {render :layout=>false}
    end
  end

  def terms
    render
  end


  private

  def allow_to
    super :all, :all=>true
  end

end












class HomeMailer < ActionMailer::Base
  def mail(options)
    self.generic_mailer(options)
  end
end

