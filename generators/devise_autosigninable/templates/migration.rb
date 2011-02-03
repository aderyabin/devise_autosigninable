class AddAutosigninableTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table <%= table_name %> do |t|
      t.autosigninable
    end
    add_index :<%= table_name %>, :autosignin_token, :unique => true
  end

  def self.down
    remove_column :<%= table_name %>, :autosignin_token
  end
end
