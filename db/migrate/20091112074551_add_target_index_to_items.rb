class AddTargetIndexToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :target_index, :string
  end

  def self.down
    remove_column :items, :target_index
  end
end
