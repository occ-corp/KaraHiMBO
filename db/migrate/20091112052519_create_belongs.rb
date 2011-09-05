# -*- coding: undecided -*-
class CreateBelongs < ActiveRecord::Migration
  def self.up
    create_table :belongs do |t|
      t.integer :emplyee_id, :null => false
      t.integer :division_id, :null => false
      t.integer :post_id
      t.integer :primary_flag

      t.timestamps
    end

    Belong.create(:emplyee_id => 1, :division_id => 1, :primary_flag => 1)
  end

  def self.down
    drop_table :belongs
  end
end
