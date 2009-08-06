ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |a|
    a.resources :users, :collection => {:search => :post}
  end

  map.resources :profiles,
  :member=>{:delete_icon=>:post}, :collection=>{:search=>:get},
  :has_many=>[:friends, :blogs, :photos, :comments, :feed_items, :messages]

  map.connect 'profiles/:id/followers', :controller => 'profiles', :action => 'followers'
  map.connect 'profiles/:id/followings', :controller => 'profiles', :action => 'followings'

  map.resources :messages, :collection => {:sent => :get}
  map.resources :blogs do |blog|
    blog.resources :comments
  end

  map.resources :forums, :collection => {:update_positions => :post} do |forum|
    forum.resources :topics, :controller => :forum_topics do |topic|
      topic.resources :posts, :controller => :forum_posts
    end
  end

  map.with_options(:controller => 'accounts') do |accounts|
    accounts.login   "/login",   :action => 'login'
    accounts.logout  "/logout",  :action => 'logout'
    accounts.signup  "/signup",  :action => 'signup'
  end

  map.with_options(:controller => 'home') do |home|
    home.home '/', :action => 'index'
    home.latest_comments '/latest_comments.rss', :action => 'latest_comments', :format=>'rss'
    home.newest_members '/newest_members.rss', :action => 'newest_members', :format=>'rss'
    home.tos '/tos', :action => 'terms'
    home.contact '/contact', :action => 'contact'
    home.all_forum_topics '/all_forum_topics', :action => 'all_forum_topics'
    home.all_wikis '/all_wikis', :action => 'all_wikis'
    home.all_blogs '/all_blogs', :action => 'all_blogs'
    home.all_members '/all_members', :action => 'all_members'
  end

  map.resources :wiki_pages do |wiki|
    wiki.resources :wiki_revisions, :collection => { :preview => :post}
  end
end

