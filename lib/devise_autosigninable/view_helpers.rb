# encoding: utf-8
require 'devise/mapping'

module Devise #:nodoc:
  module Autosigninable #:nodoc:

    # OAuth2 view helpers to easily add the link to the OAuth2 connection popup and also the necessary JS code.
    #
    module Helpers

      # Creates the link to autosignin
      def link_to_autosignin(user, link_text, options={})

        link_to link_text, Devise::autosignin_path(
            :user_id => user.id ,
            :autosignin_token => user.autosignin_token
          ) , options
      end

    end
  end
end

::ActionView::Base.send :include, Devise::Autosigninable::Helpers