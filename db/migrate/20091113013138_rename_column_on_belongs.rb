class RenameColumnOnBelongs < ActiveRecord::Migration
  def self.up
    rename_column :belongs, :emplyee_id, :employee_id
  end

  def self.down
    rename_column :belongs, :employee_id, :emplyee_id
  end
end
