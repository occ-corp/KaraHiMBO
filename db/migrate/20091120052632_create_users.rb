# -*- coding: undecided -*-
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime


    end
    add_index :users, :login, :unique => true

    ActiveRecord::Base.connection.insert <<SQL
INSERT INTO #{User.table_name} (login, crypted_password, salt, email)
VALUES ('admin', '7ceaff8197e89dcf2f913a4a1a537f2f4bc8daed', '1103f273f63c27e4ab5d58148abad3115962d17d', 'admin@example.com')
SQL
  end

  def self.down
    drop_table "users"
  end
end
