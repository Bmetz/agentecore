class WikiPagesController < ApplicationController
#  belongs_to_section :wiki

  #skip_filter :login_required, :only => [:show, :index]

  def index
    @wiki_page = WikiPage.home
    render :action => 'show'
  end

  def show
    @wiki_page = WikiPage.find_by_title(params[:id])
  end

  def new
  end

  def create
    @wiki_page = WikiPage.new params[:wiki_page]
    @wiki_page.profile = @p

    if @wiki_page.save
      flash[:notice] = 'Página salva com sucesso'
      redirect_to wiki_page_path(@wiki_page)
    else
      render :action => 'edit'
    end
  end

  def preview
    @wiki_page = WikiPage.find_by_title(params[:id])
    @wiki_page.text = @preview = params[:wiki_page][:text]
    render :action => 'edit'
  end

  def edit
    @wiki_page = WikiPage.find_or_initialize_by_title(params[:id])
  end

  def update
    @wiki_page = WikiPage.find_by_title(params[:id])
    @wiki_page.profile = @p

    if @wiki_page.update_attributes params[:wiki_page]
      flash[:notice] = 'Página salva com sucesso'
      redirect_to wiki_page_path(@wiki_page)
    else
      render :action => 'edit'
    end
  end

private

  def setup
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = params[:id] ? @topic.posts.find(params[:id]) : ForumPost.new
  end


  def allow_to
    super :all, :only => [:index, :show]
    super :admin, :all => true
    super :user, :only => [:new, :create, :edit, :update, :preview]
  end

end

