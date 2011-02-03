class AddAutosigninableTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :autosignin_token, :string
    add_index :<%= table_name %>, :autosignin_token, :unique => true
  end

  def self.down
    remove_column :<%= table_name %>, :autosignin_token
  end
end
