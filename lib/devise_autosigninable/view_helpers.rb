# encoding: utf-8
require 'devise/mapping'

module Devise #:nodoc:
  module Autosigninable #:nodoc:

    module Helpers

      # Create the link to autosignin url based on resource with given link_text
      # example: link_to_autosignin(user, user.email)
      def link_to_autosignin(resource, link_text, options={})
        link_to link_text, send("#{resource.class.to_s.downcase}_autosignin_url",
            {:object_id => resource.id,
            :autosignin_token => resource.autosignin_token}
          ) , options
      end

      # Sign in and tries to redirect first to given url and
      # then to the url specified by after_sign_in_path_for.
      #
      # If resource is blank than tries redirect to given url
      # or root url
      def sign_in_and_redirect_to_url(resource = nil, url=nil)
        if resource
          sign_in(resource)
          redirect_to url || after_sign_in_path_for(resource)
        else
          redirect_to url || root_url
        end
      end
    end
  end
end

::ActionView::Base.send :include, Devise::Autosigninable::Helpers