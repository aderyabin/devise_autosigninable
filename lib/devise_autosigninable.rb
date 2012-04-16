# DeviseAutosigninable
require 'devise'

Devise.add_module :autosigninable,
  :strategy => true,
  :model => 'devise/models/autosigninable'

require 'devise/strategies/autosigninable'