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

    # P@ssw0rd
    ActiveRecord::Base.connection.insert <<SQL
INSERT INTO #{User.table_name} (login, crypted_password, salt, email)
VALUES ('admin', '430efd4726589ecc8791bde28fd4364eb316460e', 'c0050c4ebe95f04d33ef9b617abc4bf44a3876a4', 'admin@example.com')
SQL
  end

  def self.down
    drop_table "users"
  end
end
