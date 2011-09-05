class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name, :null => false
      t.integer :second_category_id, :null => false
      t.string :unit, :null => false
      t.float :entire_index
      t.float :person_year_index, :null => false
      t.float :person_month_index, :null => false
      t.integer :comparison_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
