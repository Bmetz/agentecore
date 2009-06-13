module WikiPagesHelper
  def to_html(textile)

    # Adiciona a marcacao [[Link]] para links internos.
    text = textile.gsub(/\[\[(.+)\]\]/) do |page|
      title = $1
      page = WikiPage.find_by_title(title)
      if page
        url = url_for :controller => :wiki_pages, :action => 'show', :id => title
        "\"#{title}\":#{url}"
      else
        url = url_for :controller => :wiki_pages, :action => 'edit', :id => title
        "#{title} <span class='new_page' title='Criar nova página'> \"?\":#{url} </span>"
      end
    end

    RedCloth::new(textile).to_html
  end
end
