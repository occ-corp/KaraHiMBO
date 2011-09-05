# -*- coding: utf-8 -*-
#
# 範囲オブジェクトの走査時に
# イテレータが月ごとに動くような Date のサブクラス。
# Date では date 毎に動くが、MBO では月毎に扱うため、この形が操作しやすい。
#
#== Example
#  Date class
#  (Date.new(2009, 1)..Date.new(2009, 2)).collect {  |d| d.month }
#    => [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2]
#
#  DateMonth class
#  (DateMonth.new(2009, 1)..DateMonth.new(2009, 2)).collect { |d| d.month }
#    # => [1, 2]
#
class DateMonth < Date

  def self.actual_field_index(year, month)
    return "actual_#{year}_#{month}"
  end

  def self.rate_field_index(year, month)
    return "actual_#{year}_#{month}_rate"
  end

  #
  # DateMonth.new(+start_year+, +start_month+) から
  # DateMonth.new(+end_year+, +end_month+) までの範囲オブジェクトを
  # 生成して返します。
  # +exclude_end+ が真ならば、終端を含まない範囲オブジェクトを生成します。
  # +exclude_end+ 省略時には終端を含みます。
  #
  #  DateMonth.range(2009, 4, 2010, 3) # => Wed, 01 Apr 2009..Mon, 01 Mar 2010
  #  DateMonth.range(2013, 1, 2013, 2, true)
  #    # => Tue, 01 Jan 2013..Fri, 01 Feb 2013
  #
  def self.range(start_year, start_month, end_year, end_month,
                 exclude_end = false)
    s = new(start_year, start_month)
    e = new(end_year, end_month)
    return Range.new(s, e, exclude_end)
  end

  #
  # Same as range(+opt+["start"]["year"], +opt+["start"]["month"], +opt+["end"]["year"], +opt+["end"]["month"])
  #
  def self.range_using_hash(opt, exclude_end = false)
    s = new(opt["start"]["year"].to_i, opt["start"]["month"].to_i)
    e = new(opt["end"]["year"].to_i, opt["end"]["month"].to_i)
    return Range.new(s, e, exclude_end)
  end

  #
  # +year+ 年度の範囲オブジェクトを返す
  # +year+ 省略時は実行時の年度の範囲オブジェクトを返す。
  #
  #   DateMonth.period       # => Wed, 01 Apr 2009..Mon, 01 Mar 2010
  #   DateMonth.period(2012) # => Sun, 01 Apr 2012..Fri, 01 Mar 2013
  #
  def self.period(year = nil)
    year ||= Date.today.year
    return DateMonth.range(year, 4, year+1, 3)
  end

  # イテレータ時に、Date だと 1 日ずつ進むのを
  # ActualDate では 1 ヶ月ずつすすむように
  def succ
    self >> 1
  end

  def actual_field_index
    return self.class.actual_field_index(self.year, self.month)
  end

  def rate_field_index
    return self.class.rate_field_index(self.year, self.month)
  end

  def field_header
    return "#{self.year}年#{self.month}月"
  end

  def year_month
    return strftime("%Y%m")
  end
end
