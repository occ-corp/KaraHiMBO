# -*- coding: utf-8 -*-
module ObjectiveHelper
  # Set current period
  # 期 = 年 - 1965
  def current_period(year)
    return year.to_i - 1965
  end

  def period_name(year)
    if year.nil?
      return nil
    else
      return t(:objective_helper_fiscal_year_index, :year => year, :current_period => current_period(year))
    end
  end

  # 現在存在する Actual の year から
  # 抽出に使う年度の select オブジェクトを返す
  def select_of_period(id, selected_year = nil)
    selected_year ||= Date.today.year
    years = Actual.has_period

    # 今年度のやつが無ければ入力できないんで追加。
    cur_year = Date.today.year
    cur_year -= 1 if Date.today.month < 4

    years << cur_year unless years.include?(cur_year)

    return select_tag(id, options_for_select(years.collect { |y|
                                               [period_name(y), y]
                                             }, selected_year))
  end

  # +employee+ が所属する部署とその中での役職を表示する
  # select option を返す
  # +division+ に Division, Division ID が指定されていれば
  # その部署以下での、+employee+ の所属する部署+役職を返す
  def select_of_divisions_and_posts(employee, division = nil)
    if employee
      return employee.divisions_and_posts(division).collect { |b|
        post_name = b.post ? b.post.name : ""
        [b.division.name + " " + post_name, b.id]
      }
    else
      return Array.new
    end
  end

  def select_of_employees(employees)
    if !employees.nil?
      return employees.collect { |e| [e.name, e.id] }
    else
      return Array.new
    end
  end

  #
  # 年月の select box の間に"年月"を挿入
  # 参考: http://d.hatena.ne.jp/hichiriki/20090413/1239589622
  #
  def select_date_jp(date = Date.current, options = { }, html_options = { })
    t = select_date(date, options, html_options)
    if options[:discard_day]
      t.sub(/<\/select>(.+?)<\/select>/m, "</select>#{t(:objective_helper_select_year)}\\1</select>#{t(:objective_helper_select_month)}")
    else
      t.sub(/<\/select>(.+?)<\/select>(.+?)<\/select>/m, "</select>#{t(:objective_helper_select_year)}\\1</select>#{t(:objective_helper_select_month)}\\2</select>#{:objective_helper_select_day}")
    end
  end


  #
  # Actual から抽出したい年月の select を返す
  # プルダウンには、現在 Actual が存在する年が入る(現在年度含む)
  #
  # +start_date+ : 選択中の開始年月 (class Date)
  # +end_date+ : 選択中の終了年月 (class Date)
  #
  # return : <select>開始年月選択</select><select>終了年月選択</select>
  #
  def select_of_years_range(start_date = nil, end_date = nil, sep = t(:objective_helper_years_range_separator))
    current_year = Date.today.year
    start_date ||= Date.new(current_year, 4)
    end_date ||= Date.new(current_year+1, 3)
    
    exist_years = Actual.has_year

    select_date_options = {
      :start_year => exist_years.first.to_i,
      :end_year => exist_years.last.to_i,
      :discard_day => true,
      :use_month_numbers => true,
    }

    start_options = select_date_options.dup
    start_options[:prefix] = "range[start]"
    end_options = select_date_options.dup
    end_options[:prefix] = "range[end]"

    ret = select_date_jp(start_date, start_options)
    ret += sep
    ret += select_date_jp(end_date, end_options)
    return ret
  end

  def list_of_rank_table(table)
    sorted_table = table.to_a.sort { |a, b|
      (b[1].last <=> a[1].last)
    }

    str = "<ul id=\"rank_table\">\n"
    sorted_table.each do |t|
      str += "  #{t[0]} : "
      str += "#{t[1].first}"
      if t[1].first != t[1].last
        str += " #{t(:objective_helper_years_range_separator)} #{t[1].last}"
      end
      str += "%\n"
    end
    str += "</ul>"
  end
end
