
xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title "#{SITE_NAME} #{t(:newest_member_feed_label)}"
    xml.link SITE
    xml.description "#{t(:show_who_has_recently_signed_up_for_label)} #{SITE_NAME}"
    xml.language 'en-us'
    new_members.each do |newest_member|
      xml.item do
        xml.title "#{t(:new_member_of_label)} #{SITE_NAME}: #{newest_member.f}"
        xml.description "#{t(:see_more_at_label)}: #{link_to(newest_member.f, profile_url(newest_member))}"
        xml.author ""
        xml.pubDate newest_member.created_at
        xml.link profile_url(newest_member)
        xml.guid profile_url(newest_member)
      end
    end
  end
end
