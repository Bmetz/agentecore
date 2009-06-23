class WikiRevision < ActiveRecord::Base
  belongs_to :profile
  belongs_to :page, :class_name => 'WikiPage'
  before_save :update_page

  attr_accessor :page_title

  def page_title=(title)
    @page_title = title
    self.page = WikiPage.find_or_initialize_by_title(title)
  end


private

  def update_page
    self.page.update_attribute 'text', self.text
  end
end
