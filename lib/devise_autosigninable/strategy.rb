# encoding: utf-8
require 'devise/strategies/base'


module Devise #:nodoc:
  module Autosigninable #:nodoc:
    module Strategies #:nodoc:

      #
      class Autosigninable < ::Devise::Strategies::Base

        def valid?
         valid_controller? && valid_params? && mapping.to.respond_to?('authenticate_with_autosignin_token')
        end

        def authenticate!
          if resource = mapping.to.authenticate_with_autosignin_token(params)
            success!(resource)
          else
          fail(:invalid)
        end

        end

        protected
          def valid_controller?
            params[:controller] == 'autosignin'
          end

          def valid_params?
            params[:object_id].present? && params[:autosignin_token].present?
          end
      end
    end
  end
end

Warden::Strategies.add(:autosigninable, Devise::Autosigninable::Strategies::Autosigninable)