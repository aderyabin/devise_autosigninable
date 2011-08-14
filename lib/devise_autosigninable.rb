# DeviseAutosigninable
require 'rails'
require 'devise'
require 'devise_autosigninable/routes'
require 'devise_autosigninable/schema'
require 'devise_autosigninable/view_helpers'
require 'devise_autosigninable/strategy'

Devise.add_module :autosigninable,
  :strategy => true,
  :controller => :autosignin,
  :model => 'devise_autosigninable/model',
  :route => :autosigninable