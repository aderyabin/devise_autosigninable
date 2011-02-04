# DeviseAutosigninable
require "devise"
require 'devise_autosigninable/routes'
require 'devise_autosigninable/schema'
require 'devise_autosigninable/view_helpers'
require 'devise_autosigninable/sessions_controller.rb'

module Devise
  mattr_accessor :autosignin_path
   @@autosignin_path = '/:user_id/autosignin/:autosignin_token'
end


Devise.add_module :autosigninable,
  :model => 'devise_autosigninable/model',
  :controller => :sessions,
  :route => :autosigninable