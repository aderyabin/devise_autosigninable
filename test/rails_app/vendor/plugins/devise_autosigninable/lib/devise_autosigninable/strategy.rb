require 'devise/strategies/base'

module Devise
  module Strategies
    class Autosigninable < Base
      
      def valid?
        valid_controller? && valid_params? && mapping.to.respond_to?('authenticate_with_autosignin_token')
      end

      def authenticate!
        if resource = mapping.to.authenticate_with_autosignin_token(params)
          success!(resource)
        else
          fail!(:invalid)
        end
      end

      protected

      def valid_controller?
        'autosignin' == params[:controller]
      end

      def valid_params?
        params[:object_id].present? && params[:autosignin_token].present?
      end

    end
  end
end

Warden::Strategies.add(:autosigninable, Devise::Strategies::Autosigninable)
