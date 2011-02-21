class AddAutosigninableToPeople < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.autosigninable
    end
    add_index :people, :autosignin_token, :unique => true
  end

  def self.down
    remove_column :people, :autosignin_token
  end
end
