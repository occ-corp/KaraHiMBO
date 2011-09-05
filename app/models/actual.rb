# -*- coding: utf-8 -*-
class Actual < ActiveRecord::Base
  belongs_to :item
  belongs_to :belong

  validates_presence_of :value,:year,:month,:year_month,:item_id,:belong_id

  named_scope :range_of, lambda { |range|
    {
      :conditions => ["year_month BETWEEN ? AND ?",
                      range.first.year_month, range.last.year_month]
    } 
  }

  def validate
    errors.add(:belong_id, "is minus.") if belong_id.to_i < 0
    errors.add(:item_id, "is minus.") if item_id.to_i < 0
  end

  #
  # Actual が存在する年度を返す
  # 年度の定義は xxxx年4月 〜 (xxxx+1)年3月とする
  #
  #== Example
  # Actual.all.collect {|a| a.year_month } #=> [200904, 200912, 201003]
  # Actual.has_period #=> [2009]
  #
  def self.has_period
    return Actual.connection.select_all(<<SQL).map! { |y| y.year.to_i }
SELECT DISTINCT year 
FROM (
  SELECT (CASE WHEN month < 4 THEN year - 1 ELSE year end) AS year
  FROM #{Actual.table_name} GROUP BY year, month
) AS a
SQL
  end

  #
  # Actual が存在する年数を返す
  #
  #== Example
  # Actual.all.collect {|a| a.year_month } #=> [200904, 200912, 201003]
  # Actual.has_period #=> [2009, 2010]
  #
  def self.has_year
    Actual.find(:all, :select => :year, :group => :year).collect { |y| y.year }
  end
end
