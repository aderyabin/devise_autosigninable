module Devise
  module Models
    module Autosigninable
#      include Devise::Models::Lockable

      def self.included(base)
        base.extend ClassMethods

        base.class_eval do
          before_create :reset_autosignin_token
        end
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

      # Verifies whether an +incoming_autosignin_token
      # is the user authentication token.
      def valid_autosignin_token?(incoming_autosignin_token)
        incoming_autosignin_token == self.autosignin_token
      end

      # Checks if a resource is valid upon authentication.
      # for verifying whether an user is allowed to sign in or not. If the user
      # is locked, it should never be allowed.
      def valid_for_autosignin_token_authentication?(attributes)
        if (result = valid_autosignin_token?(attributes[:autosignin_token])) && self.class.devise_modules.include?(:lockable)
          self.failed_attempts = 0 if self.class.devise_modules.include?(:lockable)
        else
          if self.class.devise_modules.include?(:lockable)
            self.failed_attempts += 1
            lock_access! if failed_attempts > self.class.maximum_attempts
          end
        end
        save(false) if changed?
        result
      end


      module ClassMethods

        # Generate autosignin tokens unless already exists and save the records.
        def ensure_all_autosignin_tokens(batch_size=500)
          user_count = count( :conditions=>{:autosignin_token => nil})
          i = 1
          find_in_batches(:batch_size =>batch_size, :conditions=>{:autosignin_token => nil}) do |group|
            group.each { |user| user.ensure_autosignin_token! }
#            puts "Updated users: #{batch_size*i} from #{user_count}"
            i += 1
          end
        end

        # Generate autosignin tokens and save the records.
        def reset_all_autosignin_tokens(batch_size=500)
          user_count = count
          i = 1
          find_in_batches(:batch_size =>batch_size) do |group|
            group.each { |user| user.reset_autosignin_token! }
            puts "Reseted users: #{batch_size*i} from #{user_count}"
            i += 1
          end
        end

        # generation random autosignin token
        def autosignin_token
          Digest::SHA1.hexdigest("--#{Time.now.utc}--#{rand}--")
        end

        # Authenticate a user based on authentication token.
        def authenticate_with_autosignin_token(attributes={})
          resource = find_by_id(attributes["#{self.to_s.downcase}_id".to_sym])
          if resource.try(:valid_for_autosignin_token_authentication?, attributes)
            resource
          else
            nil
          end
        end
      end
    end
  end
end