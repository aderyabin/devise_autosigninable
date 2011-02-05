require 'test_helper'
require 'action_view/test_case'

class UserHelperTest < ActionView::TestCase
  include Devise::Autosigninable::Helpers
  fixtures :users

  def setup
    @user = users(:user1)
    @host = 'http://test.host'
  end

  test 'auto_signin_url_for should return link to autosignin for user' do
    assert_equal auto_signin_url_for(users(:user1)), ("#{@host}/users/#{@user.id}/autosignin/#{@user.autosignin_token}")
  end

  test 'link_to_autosignin return link to autosignin with given text' do
    assert_equal link_to_autosignin(@user, 'temp text'), (link_to 'temp text', auto_signin_url_for(@user)) 
  end




end
