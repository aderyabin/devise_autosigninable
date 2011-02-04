Devise::Schema.class_eval do
  def autosigninable
      apply_schema :autosignin_token, String
  end
end