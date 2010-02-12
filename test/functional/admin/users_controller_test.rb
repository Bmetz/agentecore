require File.dirname(__FILE__) + '/../../test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  context 'on GET to users list' do
    should "render options update" do
      Profile.stubs(:search).returns(ThinkingSphinx::Collection.new(1, 1, 1, 1))
      get :index, {}, {:user => users(:admin).id}
      assert_response :success
    end
  end

end

