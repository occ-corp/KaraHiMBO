class CreateActuals < ActiveRecord::Migration
  def self.up
    create_table :actuals do |t|
      t.float :value, :null => false
      t.integer :year, :null => false
      t.integer :month, :null => false
      t.integer :item_id, :null => false
      t.integer :belong_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :actuals
  end
end
