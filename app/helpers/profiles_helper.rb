require 'avatar/view/action_view_support'

module ProfilesHelper
  include Avatar::View::ActionViewSupport
  
#  def icon profile, size = :small, img_opts = {}
#    return "" if profile.nil?
#    img_opts = {:title => profile.full_name, :alt => profile.full_name, :class => size}.merge(img_opts)
#    link_to(avatar_tag(profile, {:size => size, :file_column_version => size }, img_opts), profile_path(profile)) rescue ''
#  end

  def icon person = nil, size = :small, img_opts = {}
    return image_tag(icon_path( person, size)) if person.blank?
    link_to(image_tag(icon_path( person, size, img_opts), :title=>person.f, :alt=>person.f), profile_path(person))
  end

  def icon_path person = nil, size = :small, img_opts = {}
    default = "/images/avatar_default_" + size.to_s + ".png"
    debugger;
    return default if person.blank?
    return default if person.icon.blank?
    x = url_for_image_column(person, :icon, size) rescue default
    x.blank? ? default : x
  end

  def location_link profile = @p
    return profile.location if profile.location == Profile::NOWHERE
    link_to h(profile.location), search_profiles_path.add_param('search[location]' => profile.location)
  end
end
