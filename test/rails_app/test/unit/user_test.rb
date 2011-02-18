require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users


  def setup
    @user_with_autosignin_token = users(:user1)
    @user_without_autosignin_token = users(:user2)
  end

  test 'autosignin_token should be generated after create' do
    new_user = User.new
    new_user.attributes  = @user_with_autosignin_token.attributes
    new_user.save
    assert_not_equal new_user.autosignin_token, @user_with_autosignin_token.autosignin_token
  end

  test 'reset_autosignin_token! should change and save autosignin_token' do
    old_token = @user_with_autosignin_token.autosignin_token

    @user_with_autosignin_token.reset_autosignin_token!
    new_token = @user_with_autosignin_token.autosignin_token

    assert_not_equal old_token, new_token
    assert_equal @user_with_autosignin_token.autosignin_token_changed?, false
  end

  test 'reset_autosignin_token should change but not save autosignin_token' do
    old_token = @user_with_autosignin_token.autosignin_token

    @user_with_autosignin_token.reset_autosignin_token
    new_token = @user_with_autosignin_token.autosignin_token

    assert_not_equal old_token, new_token
    assert_equal @user_with_autosignin_token.changed?, true
  end

  test 'ensure_autosignin_token should change but not save' do
    @user_without_autosignin_token.ensure_autosignin_token

    assert_not_nil @user_without_autosignin_token.autosignin_token
    assert_equal @user_without_autosignin_token.autosignin_token_changed?, true
  end

  test 'ensure_autosignin_token! should change and save' do
    @user_without_autosignin_token.ensure_autosignin_token!

    assert_not_nil @user_without_autosignin_token.autosignin_token
    assert_equal @user_without_autosignin_token.autosignin_token_changed?, false
  end


  test 'ensure_autosignin_token should works only with blank autosignin_token' do
    old_token = @user_with_autosignin_token.autosignin_token
    @user_without_autosignin_token.ensure_autosignin_token
    new_token = @user_with_autosignin_token.autosignin_token

    assert_equal old_token, new_token 
  end

  test 'ensure_autosignin_token! should works only with blank autosignin_token' do
    old_token = @user_with_autosignin_token.autosignin_token
    @user_without_autosignin_token.ensure_autosignin_token!
    new_token = @user_with_autosignin_token.autosignin_token

    assert_equal old_token, new_token
  end

  test 'valid_autosignin_token? should compare incoming_autosignin_token with existed' do
    assert_equal @user_with_autosignin_token.valid_autosignin_token?('01869a0f18c27087626d3ca2c4cb2d71'), true
    assert_equal @user_with_autosignin_token.valid_autosignin_token?('01869f18c27087626d3ca2c423cb2d71'), false
  end


  test 'valid_for_autosignin_token_authentication? should return true if params are corrent' do
    assert_equal true, @user_with_autosignin_token.valid_for_autosignin_token_authentication?({:autosignin_token =>'01869a0f18c27087626d3ca2c4cb2d71'})
  end

  test 'if lockable enabled valid_for_autosignin_token_authentication? should reset failed_attempts if params are corrent' do
    @user_with_autosignin_token.valid_for_autosignin_token_authentication?({:autosignin_token =>'01869a0f18c27087626d3ca2c4cb2d71'})
    assert_equal 0,  @user_with_autosignin_token.failed_attempts
  end

  test 'if lockable enabled disable valid_for_autosignin_token_authentication? should return false and increase failed_attempts if params are incorrent' do
    old_failed = @user_with_autosignin_token.failed_attempts
    assert_equal false, @user_with_autosignin_token.valid_for_autosignin_token_authentication?({:autosignin_token =>'0186918c27087626d3ca2c4cb2d71'})
    assert_equal old_failed+1, @user_with_autosignin_token.failed_attempts
  end

  test 'class method autosignin_token should return string' do
    assert_equal User.autosignin_token.class, String
  end

  test "class method length of generated signin hash should be 40" do
    assert_equal User.autosignin_token.length, 40
  end

  test "autosignin_token should generate new values" do
    assert_not_equal User.autosignin_token, User.autosignin_token
  end


  test 'ensure_all_autosignin_tokens should update only blank' do
    old_token1 = User.find(1).autosignin_token
    old_token2 = User.find(2).autosignin_token

    User.ensure_all_autosignin_tokens
    assert_equal old_token1, User.find(1).autosignin_token
    assert_not_equal old_token2, User.find(2).autosignin_token
  end


  test 'reset_all_autosignin_tokens should update all' do
    old_token1 = User.find(1).autosignin_token
    old_token2 = User.find(2).autosignin_token

    User.reset_all_autosignin_tokens

    assert_not_equal old_token1, User.find(1).autosignin_token
    assert_not_equal old_token2, User.find(2).autosignin_token
  end

  test 'authenticate_with_autosignin_token should return object by params else nil' do
    assert_equal User.authenticate_with_autosignin_token({:user_id=>1, :autosignin_token=>'01869a0f18c27087626d3ca2c4cb2d71'}), User.find(1)
    assert_nil User.authenticate_with_autosignin_token({:user_id=>2, :autosignin_token=>'01869a0f18c27087626d3ca2c4cb2d711212'})
  end


  
end
