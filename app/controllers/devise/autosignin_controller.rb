class Devise::AutosigninController < ApplicationController
  
  include Devise::Controllers::InternalHelpers
  include Devise::Autosigninable::Helpers
  
  def create
    sign_out(resource_name)
    if resource = warden.authenticate!(:scope => resource_name)
      set_flash_message :notice, :signed_in
    else
      set_now_flash_message :alert, (warden.message || :invalid)
    end
    sign_in_and_redirect_to_url(resource, params[:return_to])    
  end
end
