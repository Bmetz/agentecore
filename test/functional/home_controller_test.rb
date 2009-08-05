require File.dirname(__FILE__) + '/../test_helper'

class HomeControllerTest < ActionController::TestCase

  should 'redirect to login as guest' do
    assert_nothing_raised do
      get :contact
      assert_response 302
      assert_redirected_to 'login'
    end
  end

  should 'render contact form' do
    assert_nothing_raised do
      get :contact, {}, {:user => profiles(:user).id}
      assert_response :success
      assert_template 'contact'
    end
  end

  should 'render home page' do
    assert_nothing_raised do
      get :index, {}, {:user => profiles(:user).id}
      assert_response :success
      assert_template 'index'
    end
  end

  should 'render terms page' do
    assert_nothing_raised do
      get :terms, {}, {:user => profiles(:user).id}

      assert_response :success
      assert_template 'terms'
    end
  end

  context 'on POST to :contact' do
    should 'render contact form' do
      assert_nothing_raised do
        post :contact, {:name => 'Bob Smith', :phone => '123.123.1234', :email => 'bs@example.com', :message => 'wow'}, {:user => profiles(:user).id}

        assert_response :redirect
        assert_redirected_to contact_url
        assert_equal "Thank you for your message.  A member of our team will respond to you shortly.", flash[:notice]
      end
    end
  end

  context 'on GET to :all_forum_topics' do
    should 'redirect to login as guest' do
      assert_nothing_raised do
        get :all_forum_topics
        assert_response 302
        assert_redirected_to 'login'
      end
    end

    should 'render all forum topics page' do
      assert_nothing_raised do
        get :all_forum_topics, {}, {:user => profiles(:user).id}
        assert_response :success
        assert_template 'home/all_forum_topics'
      end
    end
  end

  context 'on GET to :all_wikis' do
    should 'redirect to login as guest' do
      assert_nothing_raised do
        get :all_wikis
        assert_response 302
        assert_redirected_to 'login'
      end
    end

    should 'render all wikis page' do
      assert_nothing_raised do
        get :all_wikis, {}, {:user => profiles(:user).id}
        assert_response :success
        assert_template 'home/all_wikis'
      end
    end
  end

  context 'on GET to :all_blogs' do
    should 'redirect to login as guest' do
      assert_nothing_raised do
        get :all_blogs
        assert_response 302
        assert_redirected_to 'login'
      end
    end

    should 'render all blogs' do
      assert_nothing_raised do
        get :all_blogs, {}, {:user => profiles(:user).id}
        assert_response :success
        assert_template 'home/all_blogs'
      end
    end
  end

  context 'on GET to :all_members' do
    should 'redirect to login as guest' do
      assert_nothing_raised do
        get :all_members
        assert_response 302
        assert_redirected_to 'login'
      end
    end

    should 'render all members' do
      assert_nothing_raised do
        get :all_members, {}, {:user => profiles(:user).id}
        assert_response :success
        assert_template 'home/all_members'
      end
    end
  end

end

