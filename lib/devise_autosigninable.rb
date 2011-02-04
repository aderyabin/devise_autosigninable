# DeviseAutosigninable
require 'devise'
require 'devise_autosigninable/routes'
require 'devise_autosigninable/schema'
require 'devise_autosigninable/view_helpers'
require 'devise_autosigninable/strategy'

module Devise
  mattr_accessor :autosignin_path
   @@autosignin_path = '/:object_id/autosignin/:autosignin_token'
end


Devise.add_module :autosigninable,
  :strategy => true,
  :controller => :autosignin,
  :model => 'devise_autosigninable/model',
  :route => :autosigninable