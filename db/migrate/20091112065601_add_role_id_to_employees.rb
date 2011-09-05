class AddRoleIdToEmployees < ActiveRecord::Migration
  def self.up
    add_column :employees, :role_id, :integer
    Employee.update_all(:role_id => 1)
  end

  def self.down
    remove_column :employees, :role_id
  end
end
