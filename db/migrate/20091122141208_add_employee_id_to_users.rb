class AddEmployeeIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :employee_id, :integer
    User.update_all(:employee_id => 1)
  end

  def self.down
    remove_column :users, :employee_id
  end
end
