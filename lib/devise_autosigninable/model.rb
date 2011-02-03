module Devise
  module Models
    module Autosigninable
      def self.included(base)
        base.extend ClassMethods
      end

      # Generate new autosignin token
      def reset_autosignin_token
        self.autosignin_token = self.class.autosignin_token
      end

      # Generate new autosignin token and save the record.
      def reset_autosignin_token!
        reset_autosignin_token
        self.save
      end

      # Generate autosignin token unless already exists.
      def ensure_autosignin_token
        self.reset_autosignin_token if self.autosignin_token.blank?
      end

      # Generate autosignin token unless already exists and save the record.
      def ensure_autosignin_token!
        self.reset_autosignin_token! if self.autosignin_token.blank?
      end
      
      module ClassMethods
        
        # Generate
        def ensure_all_autosignin_tokens
          all.collect &:ensure_autosignin_token!
        end

        # generation random autosignin token
        def autosignin_token
          ::Devise.friendly_token
        end

        
      end
    end
  end
end