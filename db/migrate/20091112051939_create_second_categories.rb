class CreateSecondCategories < ActiveRecord::Migration
  def self.up
    create_table :second_categories do |t|
      t.string :name, :null => false
      t.integer :first_category_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :second_categories
  end
end
