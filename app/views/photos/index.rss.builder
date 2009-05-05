
xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title t(:blog_title, :nome => @profile.f)
    xml.link SITE
    xml.description t(:blog_title_app, :nome => @profile.f, :app => SITE_NAME)
    xml.language 'en-us'
    @photos.each do |photo|
      xml.item do
        xml.title t(:photo_label)
        xml.description "<a href=\"#{profile_photo_url(@profile, photo)}\" title=\"#{photo.caption}\" alt=\"#{photo.caption}\" class=\"thickbox\" rel=\"user_gallery\">#{image photo, :small}</a>" + photo.caption
        xml.author "#{@profile.f}"
        xml.pubDate @profile.created_at
        xml.link profile_photo_url(@profile, photo)
        xml.guid profile_photo_url(@profile, photo)
      end
    end
  end
end
