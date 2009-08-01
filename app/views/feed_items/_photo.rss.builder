xml = xml_instance unless xml_instance.nil?
xml.item do
  p = feed_item.item
  xml.title "#{p.profile.f} #{I18n.t(:uploaded_a_photo)}"
  xml.description p.caption.blank? ? I18n.t(:no_caption_provided) : sanitize(textilize(p.caption))
  xml.author "#{p.profile.email} (#{p.profile.f})"
  xml.pubDate p.updated_at
  xml.link profile_photo_url(p.profile, p)
  xml.guid profile_photo_url(p.profile, p)
end
