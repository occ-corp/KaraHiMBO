# -*- coding: utf-8 -*-
class CreateDivisions < ActiveRecord::Migration
  def self.up
    create_table :divisions do |t|
      t.string :code, :null => false
      t.string :name, :null => false
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end

    Division.create(:code => "99999", :name => "administrator")
  end

  def self.down
    drop_table :divisions
  end
end
