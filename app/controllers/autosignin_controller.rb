class AutosigninController < ApplicationController
  include Devise::Controllers::InternalHelpers
  
  def create
    if resource = authenticate(resource_name)
      set_flash_message :notice, :signed_in
      sign_in_and_redirect(resource_name, resource, true)
    elsif [:custom, :redirect].include?(warden.result)
      throw :warden, :scope => resource_name
    else
      set_now_flash_message :alert, (warden.message || :invalid)
      render_with_scope :new
    end
  end
end
