Devise::Schema.class_eval do

  # add to migration neccessary fields for autosignin
  def autosigninable
      apply_schema :autosignin_token, String
  end
end