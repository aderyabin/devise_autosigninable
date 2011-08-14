# DeviseAutosigninable
require 'devise'

begin
  Rails::Engine
rescue
else
  module DeviseAutosigninable
    class Engine < Rails::Engine
    end
  end
  
end


Devise.add_module :autosigninable,
  :strategy => true,
  :controller => :autosignin,
  :model => 'devise_autosigninable/model',
  :route => :autosigninable

require 'devise_autosigninable/routes'
require 'devise_autosigninable/schema'
require 'devise_autosigninable/view_helpers'
require 'devise_autosigninable/strategy'