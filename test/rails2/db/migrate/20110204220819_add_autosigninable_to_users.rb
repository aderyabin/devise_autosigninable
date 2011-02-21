class AddAutosigninableToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.autosigninable
    end
    add_index :users, :autosignin_token, :unique => true
  end

  def self.down
    remove_column :users, :autosignin_token
  end
end
