class FeedItemsController < ApplicationController
  skip_filter :store_location
  before_filter :setup
  
  def destroy
    @profile.feeds.find(:first, :conditions => {:feed_item_id=>params[:id]}).destroy
    
    respond_to do |wants|
      wants.html do
        flash[:notice] = t(:item_removed_from_recent_activities)
        redirect_back_or_default @profile
      end
      wants.js { render(:update){|page| page.visual_effect :puff, "feed_item_#{params[:id]}".to_sym}}
    end
  end
  
  
  protected
  
  def allow_to
    super :user, :only => [:destroy]
  end
  
  def setup
    @profile = Profile[params[:profile_id]]
    if @p != @profile
      respond_to do |wants|
        wants.html do
          flash[:notice] = t(:sorry_you_cant_do_that)
          redirect_back_or_default @profile
        end
        wants.js { render(:update){|page| page.alert t(:sorry_you_cant_do_that)}}
      end
    end
  end
end
