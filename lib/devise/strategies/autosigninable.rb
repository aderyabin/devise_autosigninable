require 'devise/strategies/base'

module Devise
  module Strategies
    # Strategy for signing in a user, based on a authenticatable token. This works for both params
    # and http. For the former, all you need to do is to pass the params in the URL:
    #
    #   http://myapp.example.com/?user_token=SECRET
    #
    # For HTTP, you can pass the token as username and blank password. Since some clients may require
    # a password, you can pass "X" as password and it will simply be ignored.
    class Autosigninable < Authenticatable
      def store?
        super && !mapping.to.skip_session_storage.include?(:token_auth)
      end

      def authenticate!
        hash = authentication_hash.dup
        hash[:id] = hash.delete("#{mapping.name.to_s}_id".to_sym)
        resource = mapping.to.find_for_token_authentication(hash)

        if validate(resource)
          resource.after_token_authentication
          success!(resource)
        elsif !halted?
          fail(:invalid_token)
        end
      end

    private

      # Token Authenticatable can be authenticated with params in any controller and any verb.
      def valid_params_request?
        true
      end

      # Do not use remember_me behavior with token.
      def remember_me?
        false
      end

      def http_auth_hash
        Hash[*authentication_keys.zip(decode_credentials).flatten]
      end


      # Try both scoped and non scoped keys.
      def params_auth_hash
        if params[scope].kind_of?(Hash) && params[scope].has_key?(authentication_keys[1])
          params[scope]
        else
          params
        end
      end

      # Overwrite authentication keys to use token_authentication_key.
      def authentication_keys
        @authentication_keys ||= ["#{mapping.name.to_s}_id".to_sym, mapping.to.token_authentication_key]
      end
    end
  end
end

Warden::Strategies.add(:autosigninable, Devise::Strategies::Autosigninable)
