class DeviseCreatePeople < ActiveRecord::Migration
  def self.up
    create_table(:people) do |t|
      t.authenticatable :encryptor => :sha1, :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable

      t.timestamps
    end

    add_index :people, :email,                :unique => true
    add_index :people, :confirmation_token,   :unique => true
    add_index :people, :reset_password_token, :unique => true
    # add_index :people, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :people
  end
end
