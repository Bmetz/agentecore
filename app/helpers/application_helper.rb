module ApplicationHelper
  require 'digest/sha1'
  require 'net/http'
  require 'uri'
  
  

  def less_form_for name, *args, &block
    options = args.extract_options!
    form_for name, *(args << options.merge(:builder=>LessFormBuilder)), &block
  end
  
  def less_remote_form_for name, *args, &block
    options = args.extract_options!
    remote_form_for name, *(args << options.merge(:builder=>LessFormBuilder)), &block
  end
  
  

  def display_standard_flashes(message = t(:problems_with_submission))
    if flash[:notice]
      flash_to_display, level = flash[:notice], 'notice'
    elsif flash[:warning]
      flash_to_display, level = flash[:warning], 'warning'
    elsif flash[:error]
      level = 'error'
      if flash[:error].instance_of?( ActiveRecord::Errors) || flash[:error].is_a?( Hash)
        flash_to_display = message
        flash_to_display << activerecord_error_list(flash[:error])
      else
        flash_to_display = flash[:error]
      end
    else
      return
    end
    content_tag 'div', flash_to_display, :class => "flash#{level}"
  end

  def activerecord_error_list(errors)
    error_list = '<ul class="error_list">'
    error_list << errors.full_messages.collect do | m|
      "<li>#{m}</li>"
    end.to_s << '</ul>'
    error_list
  end
    
  def inline_tb_link link_text, inlineId, html = {}, tb = {}
    html_opts = {
      :title => '',
      :class => 'thickbox'
    }.merge!(html)
    tb_opts = {
      :height => 300,
      :width => 400,
      :inlineId => inlineId
    }.merge!(tb)
    
    path = '#TB_inline'.add_param(tb_opts)
    link_to(link_text, path, html_opts)
  end
  
  def tb_video_link youtube_unique_path
    return if youtube_unique_path.blank?
    youtube_unique_id = youtube_unique_path.split(/\/|\?v\=/).last.split(/\&/).first
    p youtube_unique_id
    client = YouTubeG::Client.new
    video = client.video_by YOUTUBE_BASE_URL+youtube_unique_id rescue return "(#{t(:video_not_found)})"
    id = Digest::SHA1.hexdigest("--#{Time.now}--#{video.title}--")
    inline_tb_link(video.title, h(id), {}, {:height => 355, :width => 430}) + %(<div id="#{h id}" style="display:none;">#{video.embed_html}</div>)
  end
  
  def me
    @p == @profile
  end
  
  def is_admin? user = nil
    user && user.is_admin?
  end
  
  def if_admin
    yield if is_admin? @u
  end

  include WillPaginate::ViewHelpers  

  def will_paginate_with_i18n(collection, options = {}) 
    will_paginate_without_i18n(collection, options.merge(:prev_label => I18n.t(:previous, :default=>'Previous'), :next_label => I18n.t(:next, :default=>'Next'))) 
  end

  alias_method_chain :will_paginate, :i18n
end
