class WikiRevisionsController < ApplicationController
#  belongs_to_section :wiki

  def index
    @page = WikiPage.find_by_title params[:wiki_page_id]
    @revisions = @page.revisions.reverse
  end  

  def show
    @wiki_page = WikiPage.find_by_title params[:wiki_page_id]
    @wiki_revision = WikiRevision.find_by_id params[:id]
  end

  def new
    @wiki_revision = WikiRevision.new
    @wiki_revision.page_title = params[:wiki_page_id]
    @wiki_revision.text = @wiki_revision.page.text
  end

  def create
    @wiki_revision = WikiRevision.new params[:wiki_revision]
    @wiki_revision.profile = @p
    
    if @wiki_revision.save
      flash[:notice] = 'Página salva com sucesso'  
      redirect_to wiki_page_path(@wiki_revision.page)
    else
      render :action => 'new'
    end
  end

  def preview
    @wiki_revision = WikiRevision.new params[:wiki_revision]
    @preview = @wiki_revision.text
    render :action => 'new'
  end

private

  def allow_to
    super :all, :only => [:index, :show]
    super :admin, :all => true
    super :user, :only => [:new, :create, :preview]
  end
end
