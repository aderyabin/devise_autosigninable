
require 'test_helper'

class RouteTest < ActionController::IntegrationTest

  # Replace this with your real tests.
  test "correct route for autosignin " do
    assert_routing "users/1/autosignin/01869a0f18c27087626d3ca2c4cb2d71", { :controller => "autosignin", :action => "create", :user_id => "1", :autosignin_token => '01869a0f18c27087626d3ca2c4cb2d71'}
    assert_routing "people/1/autosignin/01869a0f18c27087626d3ca2c4cb2d71", { :controller => "autosignin", :action => "create", :person_id => "1", :autosignin_token => '01869a0f18c27087626d3ca2c4cb2d71'}
  end

  
end
