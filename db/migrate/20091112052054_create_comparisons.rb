class CreateComparisons < ActiveRecord::Migration
  def self.up
    create_table :comparisons do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :comparisons
  end
end
