class PhotosController < ApplicationController
  #skip_filter :login_required
  prepend_before_filter :get_profile
  before_filter :setup



  def index
    respond_to do |wants|
      wants.html {render}
      wants.rss {render :layout=>false}
    end
  end

  def show
    redirect_to profile_photos_path(@profile)
  end


  def create
    @photo = @p.photos.build params[:photo]

    respond_to do |wants|
      if @p.photo_limit_exceeded
        wants.html do
          flash[:notice] = "Número máximo de 15 fotos excedido."
          redirect_to profile_photos_path(@p)
        end
      else
        if @photo.save
          wants.html do
            flash[:notice] = t(:photo_successfully_uploaded)
            redirect_to profile_photos_path(@p)
          end
        else
          wants.html do
            flash.now[:error] = t(:photo_could_not_be_uploaded)
            render :action => :index
          end
        end
      end
    end
  end


  def destroy
    Photo[params[:id]].destroy
    respond_to do |wants|
      wants.html do
        flash[:notice] = t(:photo_was_deleted)
        redirect_to profile_photos_path(@p)
      end
    end
  end



  private

  def allow_to
    super :owner, :all => true
    super :all, :only => [:index, :show]
  end

  def get_profile
    @profile = Profile[params[:profile_id] || params[:id]]
  end

  def setup
    @user = @profile.user
    @photos = @profile.photos.paginate(:all, :page => @page, :per_page => @per_page)
    @photo = Photo.new
  end
end

