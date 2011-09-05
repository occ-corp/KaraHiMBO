class CreateFirstCategories < ActiveRecord::Migration
  def self.up
    create_table :first_categories do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :first_categories
  end
end
