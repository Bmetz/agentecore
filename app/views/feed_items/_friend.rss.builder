xml = xml_instance unless xml_instance.nil?
xml.item do
  f = feed_item.item
  xml.title "#{f.inviter.f} #{t(:is_now_a)} #{f.description f.inviter} #{t(:of)} #{f.invited.f}"
  xml.description "#{t(:network_updated, :nome => f.inviter.f, :app => SITE_NAME)}."
  xml.author "#{f.invited.email} (#{f.invited.f})"
  xml.pubDate feed_item.created_at
  xml.link profile_url( (@profile==f.invited ? f.inviter : f.invited ) )
  xml.guid profile_url( (@profile==f.invited ? f.inviter : f.invited ) )
end
