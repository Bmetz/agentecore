require 'RedCloth'

module WikiTag
end

module WikiRefs
  def self.included(base)
    super
    base.alias_method_chain :to_html, :wiki_extensions
  end

  def refs_page(text)
    text.gsub!(/\[\[([a-zA-Z0-9]+)([^\]]+)?\]\]/) do |page|
      name, title = $1, $2
      title ||= name 
      title = title.from(1) if title.start_with?('|')

      page = WikiPage.find_by_title(name)
      if page
        url = '/wiki_pages/' + name
        %{<a href="#{url}" class='wiki_page'>#{title}</a>}
      else
        url = '/wiki_pages/' + name + '/wiki_revisions/new'
        %{#{title}<a href="#{url}" title="Criar página: #{title}" class="new_wiki_page">?</a>}
      end
    end
  end

  def to_html_with_wiki_extensions(*args)
    to_html_without_wiki_extensions(:textile, :refs_page)
  end
end

RedCloth.send :include, WikiTag
RedCloth::TextileDoc.send :include, WikiRefs
