xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0"){
  xml.channel do
    xml.title t(:activity_feed_label, :app => SITE_NAME)
    xml.link SITE
    xml.description t(:quickly_feed_label, :app => SITE_NAME)
    xml.language 'en-us'
    @feed_items.each do |feed_item|
      next if feed_item.partial == 'nil_class'
      render :partial => "feed_items/#{feed_item.partial}", :locals => {:feed_item => feed_item, :xml_instance => xml}
    end
  end
}
