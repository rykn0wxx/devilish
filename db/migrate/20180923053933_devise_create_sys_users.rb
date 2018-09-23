# frozen_string_literal: true

class DeviseCreateSysUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table :sys_users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :username,						null: false, default: ""
      t.boolean :admin,							default: false

      t.timestamps null: false
    end

    add_index :sys_users, :email,               unique: true
    add_index :sys_users, :username,						unique: true
  end
	def self.down
	  drop_table :sys_users
	end
end
