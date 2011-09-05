class CreateDivisionsItems < ActiveRecord::Migration
  def self.up
    create_table :divisions_items do |t|
      t.integer :item_id, :null => false
      t.integer :division_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :divisions_items
  end
end
