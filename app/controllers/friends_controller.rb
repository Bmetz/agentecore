class FriendsController < ApplicationController
  before_filter :setup
  #skip_before_filter :login_required, :only=>:index
  skip_before_filter :store_location, :only => [:create, :destroy]


  def create
    respond_to do |wants|
      if Friend.make_friends(@p, @profile)
        friend = @p.reload.friend_of? @profile
        wants.js {render( :update ){|page| page.replace @p.dom_id(@profile.dom_id + '_friendship_'), get_friend_link( @p, @profile)}}
      else
        message = t(:that_didnt_work_try_again)
        wants.js {render( :update ){|page| page.alert message}}
      end
    end
  end


  def destroy
    Friend.reset @p, @profile
    respond_to do |wants|
      following = @p.reload.following? @profile
      wants.js {render( :update ){|page| page.replace @p.dom_id(@profile.dom_id + '_friendship_'), get_friend_link( @p, @profile)}}
    end
  end


  def index
    @lista = @profile.friends.paginate(:all, :order => 'last_activity_at DESC', :page => @page, :per_page => 10) rescue []
  end

  protected

  def allow_to
    super :user, :all => true
    super :non_user, :only => :index
  end


  def setup
    @profile = Profile[params[:id] || params[:profile_id]]
    @user = @profile.user
  end

end

