
xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title "#{SITE_NAME} #{t(:latest_comments_feed_label)}"
    xml.link SITE
    xml.description "#{t(:all_the_action_for)} #{SITE_NAME}"
    xml.language 'en-us'
    recent_comments.each do |c|
      xml.item do
        xml.title commentable_text(c, false)
        xml.link profile_feed_item_url(@profile, c)
        xml.guid profile_feed_item_url(@profile, c)
        xml.description sanitize(textilize(c.comment))
        xml.author "#{c.profile.email} (#{c.profile.f})"
        xml.pubDate c.updated_at
      end
    end
  end
end
