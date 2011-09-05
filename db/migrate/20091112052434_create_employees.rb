# -*- coding: utf-8 -*-
class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string :code, :null => false
      t.string :name, :null => false

      t.timestamps
    end

    Employee.create(:code => "99999", :name => "administrator")
  end

  def self.down
    drop_table :employees
  end
end
