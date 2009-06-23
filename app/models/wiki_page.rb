# == Schema Information
# Schema version: 200810061001
#
# Table name: wiki_pages
#
#  id         :integer(4)    not null, primary key
#  title      :string(255)   
#  text       :text          
#  created_at :datetime      
#  updated_at :datetime      
#

class WikiPage < ActiveRecord::Base
  has_many :revisions, :class_name => 'WikiRevision', :foreign_key => 'page_id', :dependent => :destroy

  def last_revision
    self.revisions.find :first, :order => 'created_at DESC'
  end

  def to_param
    self.title
  end

  def self.home
    page = find_or_initialize_by_title('Home')

    if page.new_record?
      page.save
      page.revisions.create :text => "h1. Wiki\n\nEdite essa página.", :profile => Profile.first
    end

    page.reload # Comportamento estranho: se retirar isso só funciona na segunda vez q carregar a página, mas no console funciona direitinho.
    return page
  end
end
