# -*- coding: utf-8 -*-
class ObjectiveController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:load, :save]
  before_filter :login_required

  #
  # Grid に表示するデータは「どの部署の」「どの社員か」を決定する
  # 選択部署以下に兼任している部署があれば「どの部署か」を選択できるように
  #
  # ログインしている際のトップページは、自身のメイン所属をデータとする
  #
  def index
    # 現在表示している社員とその所属
    @belong = Belong.find_by_id(params[:belong])

    if @belong
      @employee = @belong.employee
      @division = @belong.division
    elsif current_user
      @employee = current_user.employee
      @belong = @employee.primary_belong
      @division = @belong.division
    else
      # login_required が効いていればここには到達しない
    end

    @range = extract_range(params)
    @start_date = @range.first
    @end_date = @range.last
    @employees_in_division = @division.belong_employees
  end

  def employees_live_search
    @employees = Employee.find_by_division_id(params[:value])
    render :layout => false
  end

  def belong_live_search
    if params[:employee].nil? || params[:employee].empty? || params[:employee] == "null"
      @employee = nil
      @division = nil
    else
      @employee = Employee.find(params[:employee])
      @division = Division.find(params[:division])
    end
    render :layout => false
  end

  def load
    data = ActiveSupport::JSON.decode(params[:_gt_json])
    belong_id = data["parameters"]["belong_id"]
    range = DateMonth.range_using_hash(data["parameters"]["range"])

    json = Hash.new
    json[:data] = Objective.get_with_actual(belong_id, range)
    json[:data] << Objective.rank_record(json[:data], range) unless json[:data].empty?
    json[:recordType] = 'object'
    json[:pageInfo] = { :pageSize => json[:data].size }

    ActiveRecord::Base.include_root_in_json = false
    render(:json => json)
  end

  def save
    data = ActiveSupport::JSON.decode(params[:_gt_json])
    belong_id = data["parameters"]["belong_id"]    
    update_fields = data["updatedFields"]
    update_records = data["updatedRecords"]

    begin
      Actual.transaction {
        update_records.each_with_index do |r, idx|
          item_id = r["id"].to_i

          r.slice!(*update_fields[idx].keys)
          r.each_pair do |m, value|
            (/^actual_(\d{4})_(\d{1,2})$/ =~ m)
            year = $1.to_i
            month = $2.to_i
            year_month = sprintf("%4d%02d", year, month)

            Actual.update_or_create({ :belong_id => belong_id,
                                      :item_id => item_id,
                                      :year => year, :month => month,
                                      :year_month => year_month},
                                    { :value => value.to_f })
          end
        end
      }
      render :text => "{ success : true, exception:''}"
    rescue
      render :text => "{ success : false, exception:'#{t(:objective_controller_actual_not_updated)}'}"
    end
  end

  def export_file
    if params[:belongs]
      belong_ids = params[:belongs]
      range = extract_range(params)
      data = Objective.get_with_actual(belong_ids, range)
      
      csv = Objective::Export.csv(data, range, "-s")
      send_data(csv, :type => 'text/csv; charset=Shift_JIS; header=present', :filename => "mbo.csv")
    else
      flash[:error] = t(:objective_controller_select_employee)
      flash.discard(:error)
      render :action => :export
    end
  end

  def maintenance
    begin
      @division = Division.find(params[:id])
      @objectives =  Objective.get(params[:id])
    rescue
      @divisions = Division.roots
      render :template => "objective/maintenance_select"
    end
  end

  private

  def extract_range(opt)
    if opt[:extract_period] == "1" || opt[:extract_period].nil?
      @period_year = opt[:period_year] ? opt[:period_year].to_i : Date.today.year
      return DateMonth.period(@period_year)
    else
      return DateMonth.range_using_hash(opt[:range])
    end
  end
end
