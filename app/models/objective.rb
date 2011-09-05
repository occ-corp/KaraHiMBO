# -*- coding: utf-8 -*-
class Objective
  # FIXME SigmaGrid の一部と Export で共用できるようにはしてるけど、かなり微妙
  COLUMNS = [
             {:index => :year, :header => I18n.t(:objective_column_year)},
             {:index => :employee_name, :header => I18n.t(:objective_column_employee_name)},
             {:index => :first_category_name, :header => I18n.t(:objective_column_first_category_name)},
             {:index => :second_category_name, :header => I18n.t(:objective_column_second_category_name)},
             {:index => :item, :header => I18n.t(:objective_column_item)},
             {:index => :target_index, :header => I18n.t(:objective_column_target_index)},
             {:index => :entire_index, :header => I18n.t(:objective_column_entire_index)},
             {:index => :person_year_index, :header => I18n.t(:objective_column_person_year_index)},
             {:index => :person_month_index, :header => I18n.t(:objective_column_person_month_index)}
            ]

  COLUMN_HEADERS = Hash.new
  COLUMNS.each do |c|
    COLUMN_HEADERS[c[:index]] = c[:header]
  end

  module Rank
    RANK_S = 100..100
    RANK_A = 85..99
    RANK_B = 70..84
    RANK_C = 50..69
    RANK_D = 30..49
    RANK_E = 0..29

    RANK_TABLE = {
      "S" => RANK_S,
      "A" => RANK_A,
      "B" => RANK_B,
      "C" => RANK_C,
      "D" => RANK_D,
      "E" => RANK_E
    }

    #
    # RANK_TABLE を見て、+value+ に対するランクを返す
    #   Objective::Rank.get(1)   # => "E"
    #   Objective::Rank.get(100) # => "S"
    #   Objective::Rank.get(85)  # => "A"
    #   Objective::Rank.get(84)  # => "B
    #
    def self.get(value)
      RANK_TABLE.each do |rank, range|
        return rank if range.include?(value)
      end
    end
  end

  module Export
    require 'csv'
    require 'nkf'

    def self.csv(data, range, coding = "-s")
      output = ""
      columns = COLUMNS.dup

      range.each do |r|
        y = r.year
        m = r.month
        columns << {:index => "actual_#{y}_#{m}".to_sym,
          :header => I18n.t(:objective_column_header_month, :y => y, :m => m) }
        columns << {:index => "actual_#{y}_#{m}_rate".to_sym,
          :header => I18n.t(:objective_column_header_achievement_rate, :y => y, :m => m) }
      end

      if range.is_period?
        columns << {:index => :total, :header => I18n.t(:objective_column_header_fiscal_result)}
        columns << {:index => :total_rate, :header => I18n.t(:objective_column_header_fiscal_achievement_rate)}
      end

      CSV::Writer.generate(output, ",") do |csv|
        csv << columns.collect { |c| c[:header] }
        
        data.each do |r1|
          r2 = Array.new
          columns.each do |c|
            value = r1[c[:index].to_s].to_s
            if c[:index].to_s =~ /rate$/
              if value.blank?
                value = "0"
              end
              value += '%'
            end
            r2 << value
          end

          csv << r2
        end
      end

      return NKF.nkf(coding, output)
    end
  end

  #
  # 部署ID +division_id+ の部署が持つ first_category,second_category,items を
  # 返す
  #
  # +division_id+ :: 部署ID
  # return :: Array of Hash have first_category_name, second_category_name
  #           and items attributes
  #
  def self.get(division_id)
    divisions = Division.find(division_id).full_set
    ids = "(" + divisions.collect { |d| d.id }.join(',') + ")"

    return ActiveRecord::Base.connection.select_all(<<SQL)  
SELECT i.*, i.id as item_id, i.name as item,
       fc.id as first_category_id, fc.name as first_category,
       sc.id as second_category_id,sc.name as second_category
FROM #{FirstCategory.table_name} as fc
LEFT OUTER JOIN #{SecondCategory.table_name} as sc
  on sc.first_category_id = fc.id 
LEFT OUTER JOIN #{Item.table_name} as i
  on i.second_category_id = sc.id
WHERE fc.division_id IN #{ids}
ORDER BY fc.name,sc.name,i.name
SQL
  end

  #
  # /objective で表示する Sigma Grid で用いるデータの取得
  # Objective#get と違い、item が belong.division に関連付けされている
  # ものだけを取得する
  #
  # +belong_ids+ :: 所属ID(s)
  # +range+     :: 取得する年月範囲のオブジェクト Range(DateMonth..DateMonth)
  #
  # return :: Array of Hash have first_category_name, second_category_name
  #           , items attributes and actuals
  #
  def self.get_with_actual(belong_ids, range)
    belongs = Belong.find(:all, :conditions => { :id => belong_ids })
    belongs.collect { |b| actuals_of_belong(b, range) }.flatten
  end

  # 
  # +items+ が持つ actual の月ごとの達成率の平均を求めて rank record を返す
  # もし、item 一つの達成率が 100% を越えている場合、
  # ランク取得に用いる場合は、100% に抑えてから計算する。
  #
  #   | item    | month_4_rate | month_5_rate | month_6_rate | month_7_rate |
  #   | 1       |          98% |          82% |          12% |         200% |
  #   | 2       |          56% |         100% |           0% |           0% |
  #   |---------+--------------+--------------+--------------+--------------|
  #   | avg     |          77% |          91% |           6% |         100% |
  #   | avg(m)  |          77% |          91% |           6% |          50% |
  #   | rank    |           B  |            A |           E  |           C  |
  #
  def self.rank_record(items, range)
    rate_average = Hash.new(0)
    rank_record = Hash.new

    items.each do |i|
      i.attributes.each_pair do |key, value|
        if /^(actual_\d{4}_\d{1,2}|total)_rate$/ =~ key
          value = 100 if value > 100
          rate_average[key] += value
        end
      end
    end

    range.each do |m|
      avg = (rate_average[m.rate_field_index]/items.length).truncate
      rank_record[m.actual_field_index] = I18n.t(:objective_field_index_rank)
      rank_record[m.rate_field_index] = Objective::Rank.get(avg)
      rank_record[m.rate_field_index] += "(#{avg}%)"
    end

    avg = (rate_average["total_rate"]/items.length).truncate
    rank_record["total"] = I18n.t(:objective_field_index_total_rank)
    rank_record["total_rate"] = Objective::Rank.get(avg) + "(#{avg}%)"
    return rank_record
  end
end

#
# +range+ 内での、+belong+ が持つ actuals を返す
# actuals は一つの item に対して actual_#{year}_#{month} の形で付随する
#
def actuals_of_belong(belong, range)
  divisions = Division.find(belong.division_id).ancestors_and_all_children
  ids = divisions.collect { |d| d.id }

  items = sql_items(ids, belong.employee.name, range.first.year)
  items.each do |i|
    total = 0.0
    total_rate = 0.0
    no_actual = true

    sql_actuals(belong.id, i["id"], range).each do |a|
      actual_index = DateMonth.actual_field_index(a.year, a.month)
      rate_index = DateMonth.rate_field_index(a.year, a.month)
      i[actual_index] = a.value
      i[rate_index] = actual_rate(a.value, i["person_month_index"].to_f,
                                  i["comparison_id"])
      total += i[actual_index]
      total_rate += i[rate_index] > 100 ? 100 : i[rate_index]
      no_actual = false
    end

    unless no_actual
      i["total"] = total
      if range.is_period?
        i["total_rate"] =
          actual_rate(total, i["person_year_index"].to_f, i["comparison_id"])
      else
        i["total_rate"] = total_rate/range.size
      end
    end
  end
end


#
# division +ids+ にあてはまる item を取得する
# FIXME employee_name, year は検索自体には使っていないので
#       外でやってもいいかもしれないけどどうだろう
#
def sql_items(ids, employee_name, year)
  tbi = Item.table_name
  tbf = FirstCategory.table_name
  tbs = SecondCategory.table_name

  Item.with_category.find(:all, :select => <<SQL,
DISTINCT 
  #{tbi}.*, #{tbi}.id as item_id, #{tbi}.name as item,
  #{tbs}.id as second_category_id, #{tbs}.name as second_category_name,
  #{tbf}.id as first_category_id, #{tbf}.name as first_category_name,
  '#{employee_name}' as employee_name, '#{year}' as year
SQL
                          :joins => :divisions_items,
                          :conditions => {
                            :divisions_items => { :division_id => ids }
                          })
end

#
# 所属 +belong_id+ と 項目 +item_id+ に対応し、
# 年月範囲 +range+ にある Actual を返す
#
# +belong_id+ : Belong ID
# +item_id+   : Item ID
# +range+     : Range of DateMonth
#     example +range+ = (DateMonth.new(2009,4)..DateMonth.new(2010,3))
#
def sql_actuals(belong_id, item_id, range)
  Actual.range_of(range).all(:conditions => { 
                               :item_id => item_id, :belong_id => belong_id,
                             })
end

#
# 実績値 +actual+ と指標 +target+ から達成率を求める
# +comparison+ によって「以上を目指す」「以下に抑える」の二つにわかれる
#
def actual_rate(actual, target, comparison)
  if comparison.to_i == 1
    if target == 0
      return actual > 0 ? 100 : 0
    else
      return (actual.to_f / target.to_f * 100).truncate
    end
  else
    if actual <= target
      return 100
    else
      return 0
    end
  end
end


