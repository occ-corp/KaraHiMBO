class AddDivisionIdToFirstCategories < ActiveRecord::Migration
  def self.up
    add_column :first_categories, :division_id, :integer
  end

  def self.down
    remove_column :first_categories, :division_id
  end
end
