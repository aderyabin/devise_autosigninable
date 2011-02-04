class AutosigninController < ApplicationController
  include Devise::Controllers::InternalHelpers
  include Devise::Autosigninable::Helpers
  def create
    if resource = authenticate(resource_name)
      set_flash_message :notice, :signed_in
    else
      set_now_flash_message :alert, (warden.message || :invalid)
    end
    sign_in_and_redirect_to_url(resource, params[:redirect_to])    
  end
end
