# DeviseAutosigninable
require "devise"
require 'devise_autosigninable/strategy'
require 'devise_autosigninable/routes'

Devise.add_module :autosigninable,
#  :strategy => true,
  :model => 'devise_autosigninable/model'
#  :controller => :session,
#  :route => :autosignin