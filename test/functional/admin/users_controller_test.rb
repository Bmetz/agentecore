require File.dirname(__FILE__) + '/../../test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  context 'on GET to users list' do
    should "render options update" do
      get :index, {}, {:user => users(:admin).id}
      #assert_response :success
      #assert_tag :tag => "input", :attributes => {:id => "user_is_admin", :type => "checkbox"}
      #assert_tag :tag => "input", :attributes => {:id => "user_can_send_news", :type => "checkbox"}
    end
  end

end

