require 'test_helper'


class AutosigninControllerTest < ActionController::TestCase

  include Devise::TestHelpers
  fixtures :users
  fixtures :people


  def setup
    @user = users(:confirmed_user)
    @user2 = users(:confirmed_user2)
    @confirmed_person =  people(:confirmed_person)
    @confirmed_person.confirm!
    @dummy_autosignin_token  = '111111111111111111111'
  end

  # Replace this with your real tests.
  test "if autosiginin token is incorrect user not logged in" do
    get :create, :user_id =>@user.id, :autosignin_token => @dummy_autosignin_token
    assert_blank cur_user
  end

  test 'user should be logged out if token is incorrect' do
    sign_in @user
    assert_equal cur_user, @user
    get :create, :user_id =>@user2.id, :autosignin_token =>@dummy_autosignin_token
    assert_blank cur_user
  end
  
  test 'user should be logged in as another user if logged in already' do
    sign_in @user
    assert_equal @user, cur_user
    get :create, :user_id =>@user2.id, :autosignin_token => @user2.autosignin_token
    assert_equal cur_user, @user2
  end


  test 'user should be redirected if return_to param exists' do
    get :create, :user_id=>@user.id, :autosignin_token =>@user.autosignin_token, :return_to=>'http://evilmartians.com'
    assert_redirected_to 'http://evilmartians.com'

    get :create, :user_id=>@user.id, :autosignin_token =>@dummy_autosignin_token, :return_to=>'http://evilmartians.com'
    assert_redirected_to 'http://evilmartians.com'
  end


  test 'if user is not confirmed he cant log in' do
    @person = people(:person1)
    get :create, :person_id=>@person.id, :autosignin_token =>@person.autosignin_token
    assert_blank cur_person
  end
#
  test 'if user is confirmed he can log in' do
        get :create, :person_id=>@confirmed_person.id, :autosignin_token =>@confirmed_person.autosignin_token
    assert_equal @confirmed_person, cur_person
  end

  def cur_user
    rs = warden.env['rack.session']["warden.user.user.key"]
    rs[0].find(rs[1]) rescue nil
  end

  def cur_person
    rs = warden.env['rack.session']["warden.user.person.key"]
    rs[0].find(rs[1]) rescue nil
  end

end
