
xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title t(:blog_title, :nome => @profile.f)
    xml.link SITE
    xml.description t(:blog_title, :nome => @profile.f, :app => SITE_NAME)
    xml.language 'en-us'
    @blogs.each do |blog|
      xml.item do
        xml.title blog.title
        xml.description blog_body_content(blog)
        xml.author "#{@profile.f}"
        xml.pubDate @profile.created_at
        xml.link profile_blog_url(@profile, blog)
        xml.guid profile_blog_url(@profile, blog)
      end
    end
  end
end
