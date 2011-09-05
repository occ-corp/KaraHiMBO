class AddYearMonthToActuals < ActiveRecord::Migration
  def self.up
    add_column :actuals, :year_month, :string

    Actual.all.each do |actual|
      year_month = sprintf("%4d%02d", actual.year, actual.month)
      actual.update_attribute(:year_month, year_month)
    end
  end

  def self.down
    remove_column :actuals, :year_month
  end
end
